import glosaryDatabase from "../data/services/DBPool";
import { getTraitByFeat } from "./TraitOperations";

const featClassLevelQuery = `
SELECT nivel, nombre, requisito, descripcion, habilidadId
FROM Proeza JOIN Proeza_Clase ON Proeza.id = Proeza_Clase.proezaId
WHERE claseId = ? and nivel <= ?
ORDER BY nivel;
`;

const featSubClassLevelQuery = `
SELECT nivel, nombre, requisito, descripcion, habilidadId
FROM Proeza JOIN SubclaseNivel_Proeza ON Proeza.id = SubclaseNivel_Proeza.proezaId
WHERE subclaseId = ? and nivel <= ?
ORDER BY nivel;
`;

const featByIdQuery = `
SELECT id, nivel, nombre, requisito, descripcion, habilidadId
FROM Proeza
WHERE id <= ?;
`;

const nextFeatQuery = `
SELECT nivel, nombre
FROM Proeza JOIN Proeza_Requisito ON Proeza.id = Proeza_Requisito.proezaId
WHERE requisitoId= ?
ORDER BY nombre;
`;

const getNextFeats = async (featId) => {
  const feats = await glosaryDatabase.query(nextFeatQuery, [featId]);
  const featList = [];
  //se formatean las proesas
  for (let i = 0; i < feats.length; i++) {
    const feat = feats[i];
    featList.push(feat.nombre + ' (' + feat.nivel + ')');
  }
  return featList;
};

const getTraitsByReference = async (params, query) => {
  const feats = await glosaryDatabase.query(query, params);
  //se cargan también los rasgos
  for (let i = 0; i < feats.length; i++) {
    const featId = feats[i].id;
    const traits = await getTraitByFeat(featId);
    feats[i].razgos = traits;
    const nextFeats = await getNextFeats(featId);
    feats[i].desbloquea = nextFeats;
  }
  return feats;
};

export async function getFeatsByClassLevel(id, level) {
  try {
    return await getTraitsByReference([id, level], featSubClassLevelQuery);
  } catch (err) {
    console.error("error on load feats by class and level:", err);
  }
}

export async function getFeatsBySubClassLevel(id, level) {
  try {
    return await getTraitsByReference([id, level], featClassLevelQuery);
  } catch (err) {
    console.error("error on load feats by subclass and level:", err);
  }
}

export async function getFeatById(id) {
  try {
    const orderedData =  await getTraitsByReference([id], featByIdQuery);
    return orderedData.length > 0? orderedData[0]: null;
  } catch (err) {
    console.error("error on load single feat by id:", err);
    return null;
  }
}

