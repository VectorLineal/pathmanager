import GlosaryDatabase from '../data/services/GlosaryDatabase';

const entitiesQuery = `
SELECT Entidad.id, Entidad.nombre, nivel, experiencia, Alineacion.nombre AS alineacion, Tamano.nombre AS tamano,
Raza.nombre AS raza, Clase.nombre AS clase, iniciativa, percepcion, armaduraNatural + armaduraItem + destreza + evasion as AC,salud
FROM Entidad JOIN Clase ON Entidad.claseId = Clase.id
JOIN Alineacion ON Entidad.alineacionId = Alineacion.id
JOIN Tamano ON Entidad.tamanoId = Tamano.id
JOIN Raza ON Entidad.razaId = Raza.id
ORDER BY nivel, raza, experiencia, Tamano.id, clase, Entidad.nombre;
`;
const database = new GlosaryDatabase();
await database.connect(import.meta.env.VITE_DB_PATH);

export async function getAllEntities() {
    try {
      return await database.query(entitiesQuery);
    } catch (err) {
      console.error('error on load all entities:', err);
    }
  }