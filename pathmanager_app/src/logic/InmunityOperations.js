import glosaryDatabase from "../data/services/DBPool";

const inmunityEntityQuery = `
SELECT CambioEstado.nombre
FROM Inmunidad JOIN CambioEstado ON Inmunidad.estadoId = CambioEstado.id
WHERE Inmunidad.entidadId = ?
UNION
SELECT TipoDano.nombre
FROM Resistencia JOIN TipoDano ON Resistencia.danoId = TipoDano.id
WHERE Resistencia.entidadId = ? AND Resistencia.cantidad = 0;
`;

const inmunityRaceQuery = `
SELECT Raza_Inmunidad.estadoId
FROM Raza_Inmunidad
WHERE Raza_Inmunidad.razaId = ?;
`;

const inmunityEntityCreate = `
INSERT INTO Inmunidad(estadoId, entidadId) VALUES(?, ?);
`;

export async function getInmunitiesByEntity(id) {
  try {
    return await glosaryDatabase.query(inmunityEntityQuery, [id, id]);
  } catch (err) {
    console.error("error on load inmunities by entity:", err);
  }
}

export async function getInmunitiesByRace(id) {
  try {
    return await glosaryDatabase.query(inmunityRaceQuery, [id]);
  } catch (err) {
    console.error("error on load inmunities by race:", err);
  }
}

export async function createInmunityEntity(inmunity, entity) {
  try {
    return await glosaryDatabase.create(inmunityEntityCreate, [inmunity, entity]);
  } catch (err) {
    console.error("error on create inmunity entity:", err);
  }
}
