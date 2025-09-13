import glosaryDatabase from "../data/services/DBPool";

const domainsByDeityQuery = `
SELECT Dominio.id, Dominio.nombre
FROM Dominio_Deidad JOIN Dominio ON Dominio_Deidad.dominioId = Dominio.id
WHERE Dominio_Deidad.deidadId = ?;
`;

export async function getDomainsByDeity(deity) {
  try {
    return await glosaryDatabase.query(domainsByDeityQuery, [deity]);
  } catch (err) {
    console.error("error on load domains by deity", err);
  }
}
