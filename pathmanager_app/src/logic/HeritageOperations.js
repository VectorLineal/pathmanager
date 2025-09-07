import glosaryDatabase from "../data/services/DBPool";
import { getFeatById } from "./FeatOperations";
import { getSenseById } from "./SenseOperations";
import { getAbilityById } from "./AbilityOperations";
import { getSpellById } from "./SpellOperations";


const heritageQuery = `
WITH heritage AS (SELECT id, nombre, rarezaId from Herencia WHERE razaId = 15
UNION SELECT id, nombre, rarezaId  from Herencia WHERE razaId IS NULL)

SELECT heritage.id, heritage.nombre, rarezaId, Rareza.nombre AS rareza
FROM heritage JOIN Rareza ON rarezaId = Rareza.id
ORDER BY heritage.nombre, Rareza.nombre;
`;

const singleHeritageQuery = `
SELECT Herencia.descripcion, habilidadId, proezaId, proezaId2, sentidoId, hechizoId
FROM Herencia
WHERE Herencia.id = ?;
`;

export async function getHeritageByRace(id) {
  try {
    return await glosaryDatabase.query(heritageQuery, [id]);
  } catch (err) {
    console.error("error on load all heritages:", err);
  }
}

export async function getHeritageData(id) {
  try {
    const heritages = await glosaryDatabase.query(singleHeritageQuery, [id]);
    if(heritages.length <= 0) return null;
    else{
      const heritage = heritages[0];
      //se extrae cada propiedad de cada una de las diferentes tablas
      const feats = [];
      if(backData.proezaId != null){
        const featData = await getFeatById(backData.proezaId);
        if(featData != null) feats.push(featData);
      }
      if(backData.proezaId2 != null){
        const featData = await getFeatById(backData.proezaId2);
        if(featData != null) feats.push(featData);
      }
      heritage.proezas = feats;
      const senses = [];
      if(backData.sentidoId != null){
        const senseData = await getSenseById(backData.sentidoId);
        if(senseData != null) senses.push(senseData);
      }
      heritage.sentidos = senses;
      const abilities = [];
      if(backData.habilidadId != null){
        const abilityData = await getAbilityById(backData.habilidadId);
        if(abilityData != null) abilities.push(abilityData);
      }
      heritage.habilidades = abilities;
      const spells = [];
      if(backData.hechizoId != null){
        const spellData = await getAbilityById(backData.hechizoId);
        if(spellData != null) spells.push(spellData);
      }
      heritage.hechizos = spells;
      return heritage;
    }
  } catch (err) {
    console.error("error on load single heritage:", err);
    return null;
  }
}