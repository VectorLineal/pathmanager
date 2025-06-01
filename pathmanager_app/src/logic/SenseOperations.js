import glosaryDatabase from "../data/services/DBPool";

const allsensesQuery = `
SELECT * FROM Sentido
order by nombre;
`;

const sensesEntityQuery = `
SELECT Sentido.nombre, Sentido.descripcion, Sentido_Entidad.rango
FROM Sentido_Entidad JOIN Sentido ON Sentido_Entidad.sentidoId = Sentido.id
WHERE Sentido_Entidad.entidadId = ?;
`;

const sensesRaceQuery = `
SELECT Raza_Sentido.sentidoId, Raza_Sentido.rango
FROM Raza_Sentido
WHERE Raza_Sentido.razaId = ?;
`;

const senseEntityCreate = `
INSERT INTO Sentido_Entidad(entidadId, sentidoId, rango) VALUES(?, ?, ?);
`;

export async function getAllSenses() {
  try {
    return await glosaryDatabase.query(allsensesQuery);
  } catch (err) {
    console.error("error on load all senses:", err);
  }
}

export async function getSensesByEntity(id) {
  try {
    return await glosaryDatabase.query(sensesEntityQuery, [id]);
  } catch (err) {
    console.error("error on load senses by entity:", err);
  }
}

export async function getSensesByRace(id) {
  try {
    return await glosaryDatabase.query(sensesRaceQuery, [id]);
  } catch (err) {
    console.error("error on load senses by race:", err);
  }
}

export async function createSenseEntity(entity, sense) {
  try {
    return await glosaryDatabase.create(senseEntityCreate,
      [entity, sense.sentidoId, sense.rango]
    );
  } catch (err) {
    console.error("error on create sense entity:", err);
  }
}