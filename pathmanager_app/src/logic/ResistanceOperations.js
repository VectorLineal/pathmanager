import glosaryDatabase from "../data/services/DBPool";

const resistanceEntityQuery = `
SELECT TipoDano.nombre, cantidad
FROM Resistencia JOIN TipoDano ON Resistencia.danoId = TipoDano.id
WHERE Resistencia.entidadId = ? AND Resistencia.cantidad != 0
order by cantidad;
`;

const resistanceRaceQuery = `
SELECT TipoDano.nombre, cantidad
FROM Raza_Resistencia JOIN TipoDano ON Raza_Resistencia.danoId = TipoDano.id
WHERE Raza_Resistencia.razaId = ? AND Raza_Resistencia.cantidad != 0
order by cantidad;
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
