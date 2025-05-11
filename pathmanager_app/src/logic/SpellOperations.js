import glosaryDatabase from "../data/services/DBPool";
import { getTraitBySpell } from "./TraitOperations";
import { getTraditionBySpell } from "./TraditionOperations";

const spellsEntityQuery = `
SELECT Hechizo.id, Hechizo.nombre,
CASE
  WHEN Hechizo_Entidad.aumento IS NULL THEN Hechizo.nivel
  ELSE Hechizo_Entidad.aumento
END AS nivel_final, Hechizo.nivel, efecto, critico, fallo, demora, alcance, aumentos, Escuela.nombre AS escuela, Blanco.nombre AS blancos, Hechizo_Entidad.cantidad
FROM Hechizo JOIN Escuela ON Hechizo.escuelaId = Escuela.id
JOIN Blanco ON Hechizo.blancoId = Blanco.id
JOIN Hechizo_Entidad ON Hechizo_Entidad.hechizoId = Hechizo.id
WHERE Hechizo_Entidad.entidadId = ?
ORDER by nivel_final, Hechizo.nombre, escuela;
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
