import glosaryDatabase from "../data/services/DBPool";

const alignmentsQuery = `
SELECT * FROM Alineacion;
`;

export async function getAllAlignments() {
  try {
    return await glosaryDatabase.query(alignmentsQuery);
  } catch (err) {
    console.error("error on load all alignments:", err);
  }
}