import glosaryDatabase from "../data/services/DBPool";

const sensesEntityQuery = `
SELECT Sentido.nombre, Sentido.descripcion, Sentido_Entidad.rango
FROM Sentido_Entidad JOIN Sentido ON Sentido_Entidad.sentidoId = Sentido.id
WHERE Sentido_Entidad.entidadId = ?;
`;

export async function getSensesByEntity(id) {
  try {
    return await glosaryDatabase.query(sensesEntityQuery, [id]);
  } catch (err) {
    console.error("error on load senses by entity:", err);
  }
}
