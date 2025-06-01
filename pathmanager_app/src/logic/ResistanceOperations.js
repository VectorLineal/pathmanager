import glosaryDatabase from "../data/services/DBPool";

const resistanceEntityQuery = `
SELECT TipoDano.nombre, cantidad
FROM Resistencia JOIN TipoDano ON Resistencia.danoId = TipoDano.id
WHERE Resistencia.entidadId = ? AND Resistencia.cantidad != 0
order by cantidad;
`;

const resistanceRaceQuery = `
SELECT Raza_Resistencia.danoId, Raza_Resistencia.cantidad
FROM Raza_Resistencia
WHERE Raza_Resistencia.razaId = ?;
`;

const resistanceEntityCreate = `
INSERT INTO Resistencia(entidadId, danoId, cantidad) VALUES(?, ?, ?);
`;

export async function getResWeakByEntity(id) {
  try {
    return await glosaryDatabase.query(resistanceEntityQuery, [id]);
  } catch (err) {
    console.error("error on load resistances by entity:", err);
  }
}

export async function getResWeakByRace(id) {
  try {
    return await glosaryDatabase.query(resistanceRaceQuery, [id]);
  } catch (err) {
    console.error("error on load resistances by race:", err);
  }
}

export async function createResistanceEntity(entity, resistance) {
  try {
    return await glosaryDatabase.create(resistanceEntityCreate,
      [entity, resistance.danoId, resistance.cantidad]
    );
  } catch (err) {
    console.error("error on create resistance entity:", err);
  }
}