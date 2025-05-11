import glosaryDatabase from "../data/services/DBPool";

const traditionSpellQuery = `
SELECT Tradicion.nombre
FROM Tradicion_Hechizo JOIN Tradicion ON Tradicion_Hechizo.tradicionId = Tradicion.id
WHERE Tradicion_Hechizo.hechizoId = ?;
`;

export async function getTraditionBySpell(id) {
  try {
    return await glosaryDatabase.query(traditionSpellQuery, [id]);
  } catch (err) {
    console.error("error on load traditions by spell:", err);
  }
}
