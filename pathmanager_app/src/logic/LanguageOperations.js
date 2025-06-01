import glosaryDatabase from "../data/services/DBPool";

const allLanguagesQuery = `
SELECT Lenguaje.id, Lenguaje.nombre, Rareza.nombre AS rareza
FROM Lenguaje JOIN Rareza ON Lenguaje.rarezaId = Rareza.id
ORDER BY rarezaId, Lenguaje.nombre;
`;

const languagesEntityQuery = `
SELECT Lenguaje.nombre, rarezaId, Rareza.nombre AS rareza
FROM Lenguaje_Entidad JOIN Lenguaje ON Lenguaje_Entidad.lenguajeId = Lenguaje.id
JOIN Rareza ON Lenguaje.rarezaId = Rareza.id
WHERE Lenguaje_Entidad.entidadId = ?;
`;

const languagesRaceQuery = `
SELECT Raza_Lenguaje.lenguajeId
FROM Raza_Lenguaje
WHERE Raza_Lenguaje.razaId = ?;
`;

const languageEntityCreate = `
INSERT INTO Lenguaje_Entidad(lenguajeId, entidadId) VALUES(?, ?);
`;

export async function getAllLanguages() {
  try {
    return await glosaryDatabase.query(allLanguagesQuery);
  } catch (err) {
    console.error("error on load all languages:", err);
  }
}

export async function getLanguagesByEntity(id) {
  try {
    return await glosaryDatabase.query(languagesEntityQuery, [id]);
  } catch (err) {
    console.error("error on load languages by entity:", err);
  }
}

export async function getLanguagesByRace(id) {
  try {
    return await glosaryDatabase.query(languagesRaceQuery, [id]);
  } catch (err) {
    console.error("error on load languages by race:", err);
  }
}

export async function createLanguageEntity(language, entity) {
  try {
    return await glosaryDatabase.create(languageEntityCreate, [language, entity]);
  } catch (err) {
    console.error("error on create language entity:", err);
  }
}