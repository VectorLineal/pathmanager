import glosaryDatabase from "../data/services/DBPool";
import { getAbilitiesByClassLevel } from "./AbilityOperations";
import { getFeatsByClassLevel } from "./FeatOperations";
import { getSpellsByClassLevel } from "./SpellOperations";

const classesQuery = `
SELECT * FROM Clase
ORDER BY nombre;
`;

const classLevelQuery = `
SELECT proezaClase, proezaHabilidad, proezaGeneral, proezaHerencia, incrementoHabilidad, incrementoAtributo
FROM ClaseNivel
WHERE claseId = ? and nivel = ?;
`;

export async function getAllClasses() {
  try {
    return await glosaryDatabase.query(classesQuery);
  } catch (err) {
    console.error("error on load all classes:", err);
  }
}

export async function getClassDataByIdLevel(id, level) {
  try {
    const increments = await glosaryDatabase.query(classLevelQuery, [id, level]);
    const abilities = await getAbilitiesByClassLevel(id, level);
    const feats = await getFeatsByClassLevel(id, level);
    const spells = await getSpellsByClassLevel(id, level);
    return {...increments[0], abilities, feats, spells};
  } catch (err) {
    console.error("error on load traditions by spell:", err);
  }
}