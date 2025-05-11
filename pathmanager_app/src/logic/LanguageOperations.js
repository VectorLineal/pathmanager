import glosaryDatabase from "../data/services/DBPool";

const languagesEntityQuery = `
SELECT Lenguaje.nombre, rarezaId, Rareza.nombre AS rareza
FROM Lenguaje_Entidad JOIN Lenguaje ON Lenguaje_Entidad.lenguajeId = Lenguaje.id
JOIN Rareza ON Lenguaje.rarezaId = Rareza.id
WHERE Lenguaje_Entidad.entidadId = ?;
`;

export async function getLanguagesByEntity(id) {
  try {
    return await glosaryDatabase.query(languagesEntityQuery, [id]);
  } catch (err) {
    console.error("error on load languages by entity:", err);
  }
}
