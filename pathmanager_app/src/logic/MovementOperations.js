import glosaryDatabase from "../data/services/DBPool";

const speedEntityQuery = `
SELECT Movimiento.nombre, cantidad
FROM Velocidad JOIN Movimiento ON Velocidad.movimientoId = Movimiento.id
WHERE Velocidad.entidadId = ?;
`;

export async function getSpeedsByEntity(id) {
  try {
    return await glosaryDatabase.query(speedEntityQuery, [id]);
  } catch (err) {
    console.error("error on load speeds by entity:", err);
  }
}
