import glosaryDatabase from "../data/services/DBPool";

const resistanceEntityQuery = `
SELECT TipoDano.nombre, cantidad
FROM Resistencia JOIN TipoDano ON Resistencia.danoId = TipoDano.id
WHERE Resistencia.entidadId = ? AND Resistencia.cantidad != 0
order by cantidad;
`;

export async function getResWeakByEntity(id) {
  try {
    return await glosaryDatabase.query(resistanceEntityQuery, [id]);
  } catch (err) {
    console.error("error on load resistances by entity:", err);
  }
}
