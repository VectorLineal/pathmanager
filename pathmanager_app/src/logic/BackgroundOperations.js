import glosaryDatabase from "../data/services/DBPool";
import { getFeatById } from "./FeatOperations";
import { makeLabeledOptions } from "./utilities/StructureUtils";

const backgroundQuery = `
SELECT Transfondo.id, Transfondo.nombre, Rareza.nombre as rareza
FROM Transfondo JOIN Rareza ON rarezaId = Rareza.id
ORDER BY Rareza.nombre, Transfondo.nombre;
`;

const singleBackgroundQuery = `
SELECT Transfondo.descripcion, tradicion, atributoId, at.nombre as atributo1, atributoId2,
atd.nombre as atributo2, habilidadId, hab.nombre AS habilidad, proezaId
FROM Transfondo LEFT JOIN Atributo AS at ON atributoId = at.id
LEFT JOIN Atributo AS atd ON atributoId2 = atd.id
LEFT JOIN Atributo AS hab ON habilidadId = hab.id
WHERE Transfondo.id = ?;
`;

export async function getAllBackgrounds() {
  try {
    return await glosaryDatabase.query(backgroundQuery);
  } catch (err) {
    console.error("error on load all backgrounds:", err);
  }
}
export async function getBackgroundOptions() {
  const results = await getAllBackgrounds();
  return makeLabeledOptions(results);
}

export async function getBackgroundData(id) {
  try {
    const backgrounds = await glosaryDatabase.query(singleBackgroundQuery, [id]);
    if(backgrounds.length <= 0) return null;
    else {
      //se obtienen los datos de la dote que puede o no estar asociada
      const backData = backgrounds[0];
      const feats = [];
      if(backData.proezaId != null){
        const featData = await getFeatById(backData.proezaId);
        if(featData != null) feats.push(featData);
      }
      backData.proezas = feats;

      return backData;
    }
  } catch (err) {
    console.error("error on load single background:", err);
    return null;
  }
}
export function getBackgroundDataVector(data) {
  const descriptions =  [
    {value: data.descripcion, label: 'descripción'},
  ];
  //Se agregan descripciones d elos valores que pueden ser nulos
  if(data.tradicion != null) descriptions.push({value: `Tradición: (${data.tradicion})`, label: 'Entrenado en'});
  if(data.atributo1 != null) descriptions.push({value: data.atributo1, label: 'Entrenado en'});
  if(data.atributo2 != null) descriptions.push({value: data.atributo2, label: 'Entrenado en'});
  if(data.habilidad != null) descriptions.push({value: '+1', label: data.habilidad});

  return descriptions;
}