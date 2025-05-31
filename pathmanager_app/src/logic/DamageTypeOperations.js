import glosaryDatabase from "../data/services/DBPool";

const damageTypesQuery = `
SELECT * FROM TipoDano
order by nombre;
`;

export async function getAllDamageTypes() {
  try {
    return await glosaryDatabase.query(damageTypesQuery);
  } catch (err) {
    console.error("error on load all damage types:", err);
  }
}
