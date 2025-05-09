import glosaryDatabase from "../data/services/DBPool";

const traitsQuery = `
SELECT Razgo.id, Razgo.nombre, Razgo.descripcion
FROM Razgo_Entidad JOIN Razgo ON Razgo.id = Razgo_Entidad.razgoId
WHERE Razgo_Entidad.entidadId = ?
ORDER BY Razgo.nombre;
`;

export async function getTraitByEntity(id) {
  try {
    return await glosaryDatabase.query(traitsQuery, [id]);
  } catch (err) {
    console.error("error on load all entities:", err);
  }
}