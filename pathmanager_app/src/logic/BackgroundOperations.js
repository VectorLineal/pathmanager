import glosaryDatabase from "../data/services/DBPool";

const backgroundQuery = `
SELECT id, Transfondo.nombre, rarezaId, Rareza.nombre as rareza
FROM Transfondo JOIN Rareza ON rarezaId = Rareza.id
ORDER BY nombre;
`;

const singleBackgroundQuery = `
SELECT Transfondo.descripcion, tradicion, atributoId, at.nombre as atributo1, atributoId2,
atd.nombre as atributo2, habilidadId, hab.nombre AS habilidad, proezaId
FROM Transfondo LEFT JOIN Atributo AS at ON atributoId = at.id
LEFT JOIN Atributo AS atd ON atributoId2 = atd.id
LEFT JOIN Atributo AS hab ON habilidadId = hab.id
WHERE Transfondo.id = ?;
`;

export async function getAllBackgrounds() {
  try {
    return await glosaryDatabase.query(backgroundQuery);
  } catch (err) {
    console.error("error on load all backgrounds:", err);
  }
}

export async function getBackgroundData(id) {
  try {
    const backgrounds = await glosaryDatabase.query(singleBackgroundQuery, [id]);
    if(backgrounds.length <= 0) return null;
    return backgrounds[0];
  } catch (err) {
    console.error("error on load single background:", err);
    return null;
  }
}