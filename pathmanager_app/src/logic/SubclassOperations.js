import glosaryDatabase from "../data/services/DBPool";
import { getAbilitiesBySubclassLevel } from "./AbilityOperations";
import { getFeatsBySubClassLevel } from "./FeatOperations";
import { getSpellsBySubclassLevel } from "./SpellOperations";

const SubclassTypeClassQuery = `select id, nombre from TipoSubclase where claseId = ?;`;
const SubclassByTypeQuery = `select id, nombre, descripcion from Subclase where tipoSubclaseId = ?;`;

export async function getSubclassDataByIdLevel(id, level) {
  try {
    const abilities = await getAbilitiesBySubclassLevel(id, level);
    const feats = await getFeatsBySubClassLevel(id, level);
    const spells = await getSpellsBySubclassLevel(id, level);
    return {abilities, feats, spells};
  } catch (err) {
    console.error("error on load traditions by spell:", err);
  }
}

export async function getSubclassesByClass(classId) {
  try {
    const subclasses = await glosaryDatabase.query(SubclassTypeClassQuery, [classId]);
    if(subclasses.length > 0){
        const response = [];
        for(let i = 0; i < subclasses.length; i++){
            const subType = subclasses[i];
            const subData = await glosaryDatabase.query(SubclassByTypeQuery, [subType.id]);
            response.push({name: subType.nombre, data: subData});
        }
        return response;
    }else return [];
  } catch (err) {
    console.error("error on load all traditions:", err);
  }
}