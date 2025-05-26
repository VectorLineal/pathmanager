import glosaryDatabase from "../data/services/DBPool";

const classesQuery = `
SELECT * FROM Clase
ORDER BY nombre;
`;

export async function getAllClasses() {
  try {
    return await glosaryDatabase.query(classesQuery);
  } catch (err) {
    console.error("error on load all classes:", err);
  }
}