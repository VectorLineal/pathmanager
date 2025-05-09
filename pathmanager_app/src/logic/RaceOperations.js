import glosaryDatabase from "../data/services/DBPool";

const racesQuery = `
SELECT * FROM Raza;
`;

export async function getAllRaces() {
  try {
    return await glosaryDatabase.query(racesQuery);
  } catch (err) {
    console.error("error on load all races:", err);
  }
}