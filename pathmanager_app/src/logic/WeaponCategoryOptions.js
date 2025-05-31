import glosaryDatabase from "../data/services/DBPool";

const categoriesQuery = `
SELECT * FROM Categoria order by nombre;
`;

export async function getAllWeaponCategories() {
  try {
    return await glosaryDatabase.query(categoriesQuery);
  } catch (err) {
    console.error("error on load all weapon categories:", err);
  }
}