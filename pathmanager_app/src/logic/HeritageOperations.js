import glosaryDatabase from "../data/services/DBPool";

const heritageQuery = `
WITH heritage AS (SELECT id, nombre, rarezaId from Herencia WHERE razaId = 15
UNION SELECT id, nombre, rarezaId  from Herencia WHERE razaId IS NULL)

SELECT heritage.id, heritage.nombre, rarezaId, Rareza.nombre AS rareza
FROM heritage JOIN Rareza ON rarezaId = Rareza.id
ORDER BY heritage.nombre, Rareza.nombre;
`;

const singleHeritageQuery = `
SELECT Herencia.descripcion, habilidadId, HabilidadEspecial.efecto, proezaId, proezaId2, sentidoId,
Sentido.nombre AS sentido, Sentido.descripcion as sDescripcion, hechizoId
FROM Herencia LEFT JOIN HabilidadEspecial ON habilidadId = HabilidadEspecial.id
LEFT JOIN Sentido ON sentidoId = Sentido.id
WHERE Herencia.id = ?;
`;

export async function getHeritageByRace(id) {
  try {
    return await glosaryDatabase.query(heritageQuery, [id]);
  } catch (err) {
    console.error("error on load all heritages:", err);
  }
}

export async function getHeritageData(id) {
  try {
    const heritages = await glosaryDatabase.query(singleHeritageQuery, [id]);
    if(heritages.length <= 0) return null;
    return heritages[0];
  } catch (err) {
    console.error("error on load single heritage:", err);
    return null;
  }
}