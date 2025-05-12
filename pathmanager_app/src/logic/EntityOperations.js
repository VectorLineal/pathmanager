import glosaryDatabase from "../data/services/DBPool";
import { getTraitByEntity } from "./TraitOperations";
import { getSensesByEntity } from "./SenseOperations";
import { getLanguagesByEntity } from "./LanguageOperations";
import { getSpeedsByEntity } from "./MovementOperations";
import { getInmunitiesByEntity } from "./InmunityOperations";
import { getResWeakByEntity } from "./ResistanceOperations";
import { getAttacksByEntity } from "./AttackOperations";
import { getAbilitiesByEntity } from "./AbilityOperations";
import { getFeatsByEntity } from "./FeatOperations";
import { getSpellsByEntity } from "./SpellOperations";

const entitiesQuery = `
SELECT Entidad.id, Entidad.nombre, nivel, experiencia, Alineacion.nombre AS alineacion, Tamano.nombre AS tamano,
Raza.nombre AS raza, Clase.nombre AS clase, iniciativa, percepcion, armaduraNatural + armaduraItem + destreza + evasion as AC,salud
FROM Entidad JOIN Clase ON Entidad.claseId = Clase.id
JOIN Alineacion ON Entidad.alineacionId = Alineacion.id
JOIN Tamano ON Entidad.tamanoId = Tamano.id
JOIN Raza ON Entidad.razaId = Raza.id
ORDER BY nivel, raza, experiencia, Tamano.id, clase, Entidad.nombre;
`;

const entityQuery = `
SELECT Entidad.nombre, nivel, experiencia, alineacionId, Alineacion.nombre AS alineacion, tamanoId,
Tamano.nombre AS tamano, razaId, Raza.nombre AS raza, claseId, Clase.nombre AS clase, iniciativa,
percepcion, armaduraNatural + armaduraItem + destreza + evasion as AC,
armaduraNatural + armaduraItem as FFAC, salud, fortaleza, reflejos, voluntad, fuerza, destreza,
constitucion, inteligencia, sabiduria, carisma, acrobacia, atletismo, fabricacion, engano, diplomacia,
intimidacion, tradicion, medicina, naturaleza, ocultismo, actuacion, religion, sociedad, sigilo,
supervivencia, robo, dinero, tesoro, descripcion
FROM Entidad JOIN Clase ON Entidad.claseId = Clase.id
JOIN Alineacion ON Entidad.alineacionId = Alineacion.id
JOIN Tamano ON Entidad.tamanoId = Tamano.id
JOIN Raza ON Entidad.razaId = Raza.id
WHERE Entidad.id = ?;
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

export async function getEntity(id) {
  try {
    console.log("input id:", id);
    const eQuery = await glosaryDatabase.query(entityQuery, [id]);
    console.log("query:", eQuery);
    const entity = eQuery[0];
    console.log("queried entity:", entity);
    //se añaden datos en forma de arreglos
    const traits = await getTraitByEntity(id);
    entity.razgos = traits;
    const senses = await getSensesByEntity(id);
    entity.sentidos = senses;
    const languages = await getLanguagesByEntity(id);
    entity.lenguages = languages;
    const speeds = await getSpeedsByEntity(id);
    entity.velocidades = speeds;
    const inmunities = await getInmunitiesByEntity(id);
    entity.inmunidades = inmunities;
    //trae resistencias y debilidades, siendo debilidades cuando cantidad es menor a 0 y resistencias cuando es mayor
    const weakres = await getResWeakByEntity(id);
    entity.resistencias = weakres;
    const attacks = await getAttacksByEntity(id);
    entity.ataques = attacks;
    const abilities = await getAbilitiesByEntity(id);
    entity.habilidades = abilities;
    const feats = await getFeatsByEntity(id);
    entity.proezas = feats;
    const spells = await getSpellsByEntity(id);
    entity.hechizos = abilities;

    return entity;
  } catch (err) {
    console.error("error on load single entitiy:", err);
  }
}
