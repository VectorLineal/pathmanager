import glosaryDatabase from "../data/services/DBPool";

const attributesQuery = `
SELECT * FROM Atributo ORDER BY nombre;
`;
const attributeItemCreateQuery = `
INSERT INTO Item_Atributo(itemId, atributoId, cantidad)
VALUES(?, ?, ?);
`;

export async function getAllAttributes() {
  try {
    return await glosaryDatabase.query(attributesQuery);
  } catch (err) {
    console.error("error on load all attributes:", err);
  }
}

export async function createAtributeByItem(item, attribute, amount) {
  try {
    return await glosaryDatabase.create(attributeItemCreateQuery, [item, attribute, amount]);
  } catch (err) {
    console.error("error on create attribute by item:", err);
    return -1;
  }
}