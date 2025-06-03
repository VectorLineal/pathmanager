import glosaryDatabase from "../data/services/DBPool";

const allTraditionsQuery = `SELECT * FROM Tradicion ORDER BY nombre;`;

const traditionSpellQuery = `
SELECT Tradicion.nombre
FROM Tradicion_Hechizo JOIN Tradicion ON Tradicion_Hechizo.tradicionId = Tradicion.id
WHERE Tradicion_Hechizo.hechizoId = ?;
`;

const traditionSpellCreate = `
INSERT INTO Tradicion_Hechizo(tradicionId, hechizoId) VALUES(?, ?);
`;

export async function getTraditionBySpell(id) {
  try {
    return await glosaryDatabase.query(traditionSpellQuery, [id]);
  } catch (err) {
    console.error("error on load traditions by spell:", err);
  }
}

export async function getAllTraditions() {
  try {
    return await glosaryDatabase.query(allTraditionsQuery);
  } catch (err) {
    console.error("error on load all traditions:", err);
  }
}

export async function createTraditionSpell(tradition, spell) {
  try {
    return await glosaryDatabase.create(traditionSpellCreate, [tradition, spell]);
  } catch (err) {
    console.error("error on create tradition spell:", err);
  }
}
