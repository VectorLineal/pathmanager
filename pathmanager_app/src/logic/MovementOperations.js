import glosaryDatabase from "../data/services/DBPool";

const allMovementsQuery = `
SELECT * FROM Movimiento;
`;

const speedEntityQuery = `
SELECT Movimiento.nombre, cantidad
FROM Velocidad JOIN Movimiento ON Velocidad.movimientoId = Movimiento.id
WHERE Velocidad.entidadId = ?;
`;

const speedRaceQuery = `
SELECT Movimiento.nombre, cantidad
FROM Raza_Velocidad JOIN Movimiento ON Raza_Velocidad.movimientoId = Movimiento.id
WHERE Raza_Velocidad.razaId = ?;
`;

export async function getAllMovementTypes() {
  try {
    return await glosaryDatabase.query(allMovementsQuery);
  } catch (err) {
    console.error("error on load all movement types:", err);
  }
}

export async function getSpeedsByEntity(id) {
  try {
    return await glosaryDatabase.query(speedEntityQuery, [id]);
  } catch (err) {
    console.error("error on load speeds by entity:", err);
  }
}

export async function getSpeedsByRace(id) {
  try {
    return await glosaryDatabase.query(speedRaceQuery, [id]);
  } catch (err) {
    console.error("error on load speeds by race:", err);
  }
}
