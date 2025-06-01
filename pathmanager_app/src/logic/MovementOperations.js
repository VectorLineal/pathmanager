import glosaryDatabase from "../data/services/DBPool";

const allMovementsQuery = `
SELECT * FROM Movimiento
order by nombre;
`;

const speedEntityQuery = `
SELECT Movimiento.nombre, cantidad
FROM Velocidad JOIN Movimiento ON Velocidad.movimientoId = Movimiento.id
WHERE Velocidad.entidadId = ?;
`;

const speedRaceQuery = `
SELECT Raza_Velocidad.movimientoId , cantidad
FROM Raza_Velocidad
WHERE Raza_Velocidad.razaId = ?;
`;

const movementEntityCreate = `
INSERT INTO Velocidad(entidadId, movimientoId , cantidad) VALUES(?, ?, ?);
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

export async function createMovementEntity(entity, movement) {
  try {
    return await glosaryDatabase.create(movementEntityCreate,
      [entity, movement.movimientoId, movement.cantidad]
    );
  } catch (err) {
    console.error("error on create movement entity:", err);
  }
}