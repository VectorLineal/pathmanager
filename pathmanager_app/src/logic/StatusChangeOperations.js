import glosaryDatabase from "../data/services/DBPool";

const statusChangesQuery = `
SELECT * FROM CambioEstado
order by nombre;
`;

export async function getAllStatusChanges() {
  try {
    return await glosaryDatabase.query(statusChangesQuery);
  } catch (err) {
    console.error("error on load all status changes:", err);
  }
}
