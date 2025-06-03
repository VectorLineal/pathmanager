import glosaryDatabase from "../data/services/DBPool";

const allSchoolsQuery = `SELECT * FROM Escuela ORDER BY nombre;`;


export async function getAllSchools() {
  try {
    return await glosaryDatabase.query(allSchoolsQuery);
  } catch (err) {
    console.error("error on load all schools:", err);
  }
}