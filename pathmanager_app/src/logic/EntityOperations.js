import glosaryDatabase from "../data/services/DBPool";
import { getTraitByEntity } from "./TraitOperation";

const entitiesQuery = `
SELECT Entidad.id, Entidad.nombre, nivel, experiencia, Alineacion.nombre AS alineacion, Tamano.nombre AS tamano,
Raza.nombre AS raza, Clase.nombre AS clase, iniciativa, percepcion, armaduraNatural + armaduraItem + destreza + evasion as AC,salud
FROM Entidad JOIN Clase ON Entidad.claseId = Clase.id
JOIN Alineacion ON Entidad.alineacionId = Alineacion.id
JOIN Tamano ON Entidad.tamanoId = Tamano.id
JOIN Raza ON Entidad.razaId = Raza.id
ORDER BY nivel, raza, experiencia, Tamano.id, clase, Entidad.nombre;
`;

export async function getAllEntities() {
  try {
    const entities = await glosaryDatabase.query(entitiesQuery);
    for(let i = 0; i < entities.length; i++){
      const traits = await getTraitByEntity(entities[i].id);
      entities[i].razgos = traits;
    }
    return entities;
  } catch (err) {
    console.error("error on load all entities:", err);
  }
}