import glosaryDatabase from "../data/services/DBPool";

const alignmentsQuery = `
SELECT * FROM Alineacion;
`;
export const GOOD_ALIGNMENTS = [2, 5, 8];
export const EVIL_ALIGNMENTS = [3, 6, 9];
export const CHAOTIC_ALIGNMENTS = [7, 8, 9];
export const LAWFUL_ALIGNMENTS = [4, 5, 6];

export async function getAllAlignments() {
  try {
    return await glosaryDatabase.query(alignmentsQuery);
  } catch (err) {
    console.error("error on load all alignments:", err);
  }
}
