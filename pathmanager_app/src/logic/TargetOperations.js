import glosaryDatabase from "../data/services/DBPool";

const allTargetsQuery = `SELECT * FROM Blanco ORDER BY nombre;`;


export async function getAllTargets() {
  try {
    return await glosaryDatabase.query(allTargetsQuery);
  } catch (err) {
    console.error("error on load all targets:", err);
  }
}