import glosaryDatabase from "../data/services/DBPool";

const sizesQuery = `
SELECT * FROM Tamano;
`;

export async function getAllSizes() {
  try {
    return await glosaryDatabase.query(sizesQuery);
  } catch (err) {
    console.error("error on load all sizes:", err);
  }
}