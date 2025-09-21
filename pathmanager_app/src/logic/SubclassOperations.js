import glosaryDatabase from "../data/services/DBPool";
import { getAbilitiesBySubclassLevel } from "./AbilityOperations";
import { getFeatsBySubClassLevel } from "./FeatOperations";
import { getSpellsBySubclassLevel } from "./SpellOperations";

const SubclassTypeClassQuery = `select id, nombre from TipoSubclase where claseId = ?;`;
const SubclassByTypeQuery = `select id, nombre, descripcion from Subclase where tipoSubclaseId = ?;`;

const holyCauses = [39, 44];
const unholyCauses = [38, 40];

function getSpecialArcaneSchool(id){
  switch(id){
    default:
      return 0;
    case 56:
    case 63:
      return 1;
    case 53:
    case 54:
    case 55:
    case 64:
      return 2;
    case 52:
    case 62:
      return 3;
    case 57:
    case 58:
    case 59:
    case 60:
    case 61:
      return 4;
  }
}
export function getSanctificationBySubclass(id) {
  if(holyCauses.includes(id)) return 1;
  else if(unholyCauses.includes(id)) return -1;
  else return 0;
}
export async function getSubclassDataByIdLevel(id, level) {
  try {
    const abilities = await getAbilitiesBySubclassLevel(id, level);
    const feats = await getFeatsBySubClassLevel(id, level);
    const spells = await getSpellsBySubclassLevel(id, level);
    return {abilities, feats, spells, spellTradition: getSpecialArcaneSchool(id)};
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