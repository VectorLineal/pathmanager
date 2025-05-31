import glosaryDatabase from "../data/services/DBPool";

const typesQuery = `
SELECT * FROM Tipo order by nombre;
`;

export async function getAllWeaponTypes() {
  try {
    return await glosaryDatabase.query(typesQuery);
  } catch (err) {
    console.error("error on load all weapon types:", err);
  }
}