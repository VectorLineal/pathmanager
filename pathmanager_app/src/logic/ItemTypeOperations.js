import glosaryDatabase from "../data/services/DBPool";

const typesQuery = `
SELECT * FROM TipoItem order by nombre;
`;

export async function getAllItemTypes() {
  try {
    return await glosaryDatabase.query(typesQuery);
  } catch (err) {
    console.error("error on load all item types:", err);
  }
}