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

const getTraitsByReference = async (params, query) => {
  const feats = await glosaryDatabase.query(query, params);
  //se cargan también los rasgos
  for (let i = 0; i < feats.length; i++) {
    const traits = await getTraitByFeat(feats[i].id);
    feats[i].razgos = traits;
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
