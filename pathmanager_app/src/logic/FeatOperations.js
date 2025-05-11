import glosaryDatabase from "../data/services/DBPool";

const featEntityQuery = `
select nombre, descripcion
FROM Proeza_Entidad JOIN Proeza ON Proeza.id = Proeza_Entidad.proezaId
WHERE Proeza_Entidad.entidadId = ?
order by Proeza.nombre;
`;

export async function getFeatsByEntity(id) {
  try {
    return await glosaryDatabase.query(featEntityQuery, [id]);
  } catch (err) {
    console.error("error on load feats by entity:", err);
  }
}
