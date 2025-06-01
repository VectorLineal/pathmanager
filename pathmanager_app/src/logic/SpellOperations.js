import glosaryDatabase from "../data/services/DBPool";
import { getTraitBySpell } from "./TraitOperations";
import { getTraditionBySpell } from "./TraditionOperations";

const spellsEntityQuery = `
SELECT Hechizo.id, Hechizo.nombre,
CASE
  WHEN Hechizo_Entidad.aumento IS NULL THEN Hechizo.nivel
  ELSE Hechizo_Entidad.aumento
END AS nivel_final, Hechizo.nivel, efecto, critico, fallo, demora, alcance, aumentos,
Escuela.nombre AS escuela, Blanco.nombre AS blancos, Hechizo_Entidad.cantidad
FROM Hechizo JOIN Escuela ON Hechizo.escuelaId = Escuela.id
JOIN Blanco ON Hechizo.blancoId = Blanco.id
JOIN Hechizo_Entidad ON Hechizo_Entidad.hechizoId = Hechizo.id
WHERE Hechizo_Entidad.entidadId = ?
ORDER by nivel_final, Hechizo.nombre, escuela;
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

export async function getSpellsByEntity(id) {
  try {
    const spells = await glosaryDatabase.query(spellsEntityQuery, [id]);
    //se cargan también los razgos y tradiciones
    for(let i = 0; i < spells.length; i++){
      const traits = await getTraitBySpell(spells[i].id);
      const traditions = await getTraditionBySpell(spells[i].id);
      spells[i].razgos = traits;
      spells[i].tradiciones = traditions;
    }
    return spells;
  } catch (err) {
    console.error("error on load spells by entity:", err);
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
