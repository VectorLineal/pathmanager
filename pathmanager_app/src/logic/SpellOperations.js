import glosaryDatabase from "../data/services/DBPool";
import { getTraitBySpell, createTraitSpell } from "./TraitOperations";
import { getTraditionBySpell, createTraditionSpell } from "./TraditionOperations";

const spellsEntityQuery = `
SELECT Hechizo.id, Hechizo.nombre,
CASE
  WHEN Hechizo_Entidad.aumento IS NULL THEN Hechizo.nivel
  ELSE Hechizo_Entidad.aumento
END AS nivel_final, Hechizo.nivel, efecto, critico, fallo, demora, alcance, aumentos,
Escuela.nombre AS escuela, Blanco.nombre AS blancos, Hechizo_Entidad.cantidad, Clase.nombre AS clase
FROM Hechizo JOIN Escuela ON Hechizo.escuelaId = Escuela.id
JOIN Blanco ON Hechizo.blancoId = Blanco.id
JOIN Hechizo_Entidad ON Hechizo_Entidad.hechizoId = Hechizo.id
LEFT JOIN Clase ON Hechizo.claseId = Clase.id
WHERE Hechizo_Entidad.entidadId = ?
ORDER by nivel_final, Hechizo.nombre, escuela;
`;

const focusSpellsClassQuery = `
SELECT Hechizo.id, Hechizo.nombre || '(' || Escuela.nombre || ')' AS nombre, Hechizo.nivel
FROM Hechizo JOIN Escuela ON Hechizo.escuelaId = Escuela.id
JOIN Clase ON Hechizo.claseId = Clase.id
WHERE Hechizo.claseId = ? AND Hechizo.nivel <= ?
ORDER by Hechizo.nivel, Hechizo.nombre, Escuela.id;
`;

const allSpellsQuery = `
SELECT Hechizo.id, Hechizo.nombre, Hechizo.nivel, efecto, critico, fallo, demora, alcance, aumentos,
Escuela.nombre AS escuela, Blanco.nombre AS blancos
FROM Hechizo JOIN Escuela ON Hechizo.escuelaId = Escuela.id
JOIN Blanco ON Hechizo.blancoId = Blanco.id
WHERE Hechizo.claseId IS NULL
ORDER by Hechizo.nivel, Hechizo.nombre, escuela;
`;

const allFocusSpellsQuery = `
SELECT Hechizo.id, Hechizo.nombre, Hechizo.nivel, efecto, critico, fallo, demora, alcance, aumentos,
Escuela.nombre AS escuela, Blanco.nombre AS blancos, Clase.nombre AS clase
FROM Hechizo JOIN Escuela ON Hechizo.escuelaId = Escuela.id
JOIN Blanco ON Hechizo.blancoId = Blanco.id
JOIN Clase ON Hechizo.claseId = Clase.id
ORDER by Hechizo.nivel, Hechizo.nombre, escuela;
`;

const spellsByTraditionCasterLevelQuery = `
SELECT Hechizo.id, Hechizo.nombre || '(' || Escuela.nombre || ')' AS nombre, hechizo.nivel
FROM Hechizo JOIN Tradicion_Hechizo on Hechizo.id = Tradicion_Hechizo.hechizoId
JOIN Escuela on Hechizo.escuelaId = Escuela.id
WHERE tradicionId = ? AND Hechizo.nivel <= ?
ORDER BY Hechizo.nivel, Hechizo.escuelaId, Hechizo.nombre;
`;

const createSpellEntityQuery = `
INSERT INTO Hechizo_Entidad(entidadId, hechizoId, cantidad, aumento)
VALUES(?, ?, ?, ?);
`;

const createSpellQuery = `
INSERT INTO Hechizo(nombre, fallo, efecto, critico, demora, nivel, alcance, aumentos, escuelaId, blancoId)
VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
`;
const createFocusSpellQuery = `
INSERT INTO Hechizo(nombre, fallo, efecto, critico, demora, nivel, alcance, aumentos, claseId, escuelaId, blancoId)
VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
`;

export async function getAllSpells(isFocus) {
  try {
    const spells = await glosaryDatabase.query(isFocus? allFocusSpellsQuery:allSpellsQuery);
    //se cargan también los razgos y tradiciones
    for(let i = 0; i < spells.length; i++){
      const traits = await getTraitBySpell(spells[i].id);
      spells[i].razgos = traits;
      if(!isFocus){
        const traditions = await getTraditionBySpell(spells[i].id);
        spells[i].tradiciones = traditions;
      }
    }
    return spells;
  } catch (err) {
    console.error("error on load all spells:", err);
  }
}

export async function getSpellsByEntity(id) {
  try {
    const spells = await glosaryDatabase.query(spellsEntityQuery, [id]);
    //se cargan también los razgos y tradiciones
    for(let i = 0; i < spells.length; i++){
      const traits = await getTraitBySpell(spells[i].id);
      spells[i].razgos = traits;
      //solo se cargan las tradiciones cuando no es un hechizo de foco
      if(spells[i].clase == null){
        const traditions = await getTraditionBySpell(spells[i].id);
        spells[i].tradiciones = traditions;
      }
    }
    return spells;
  } catch (err) {
    console.error("error on load spells by entity:", err);
  }
}

export async function getFocusSpellsByClassLevel(id, entityLevel) {
  const level = Math.ceil(entityLevel / 2);
  try {
    const spells = await glosaryDatabase.query(focusSpellsClassQuery, [id, level]);
    
    return spells;
  } catch (err) {
    console.error("error on load focus spells by class and level:", err);
  }
}

export async function getSpellsByTraditionCasterLevel(tradition, entityLevel) {
  const level = Math.ceil(entityLevel / 2);
  try {
    const spells = await glosaryDatabase.query(spellsByTraditionCasterLevelQuery, [tradition, level]);
    return spells;
  } catch (err) {
    console.error("error on load spells by caster level and tradition:", err);
  }
}

export async function createSpellEntity(entity, spell) {
  try {
    return await glosaryDatabase.create(createSpellEntityQuery,
      [entity, spell.hechizoId, spell.cantidad, spell.aumento]
    );
  } catch (err) {
    console.error("error on create spell entity:", err);
  }
}

export async function createSpell(spell, isFocus) {
  try {
    //se crea el hechizo como tal y se retorna el Id
    const hechizoId = await glosaryDatabase.create(isFocus? createFocusSpellQuery:createSpellQuery, spell.getCreationVector());
    console.log("completed spell transaction:", hechizoId);
    //se crea cada una de las relaciones muchos a muchos
    for(let i = 0; i < spell.traits.length; i++){
      await createTraitSpell(spell.traits[i], hechizoId);
    };
    if(!isFocus){
      for(let i = 0; i < spell.traditions.length; i++){
        await createTraditionSpell(spell.traditions[i], hechizoId);
      };
    }
    return true;
  } catch (err) {
    console.error("error on create spell:", err);
    return false;
  }
}
