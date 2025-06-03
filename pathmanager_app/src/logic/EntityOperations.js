import glosaryDatabase from "../data/services/DBPool";
import { getTraitByEntity, createTraitEntity } from "./TraitOperations";
import { getSensesByEntity, createSenseEntity } from "./SenseOperations";
import { getLanguagesByEntity, createLanguageEntity } from "./LanguageOperations";
import { getSpeedsByEntity, createMovementEntity } from "./MovementOperations";
import { getInmunitiesByEntity, createInmunityEntity } from "./InmunityOperations";
import { getResWeakByEntity, createResistanceEntity } from "./ResistanceOperations";
import { getAttacksByEntity, createAttackEntity } from "./AttackOperations";
import { getAbilitiesByEntity, createAbilityEntity } from "./AbilityOperations";
import { getSpellsByEntity, createSpellEntity } from "./SpellOperations";

const entitiesQuery = `
SELECT Entidad.id, Entidad.nombre, nivel, experiencia, Alineacion.nombre AS alineacion,
Tamano.nombre AS tamano, Raza.nombre AS raza, Clase.nombre AS clase, Entidad.percepcion,
armaduraNatural + armaduraItem + Entidad.destreza + evasion as AC, Entidad.salud
FROM Entidad JOIN Clase ON Entidad.claseId = Clase.id
JOIN Alineacion ON Entidad.alineacionId = Alineacion.id
JOIN Tamano ON Entidad.tamanoId = Tamano.id
JOIN Raza ON Entidad.razaId = Raza.id
ORDER BY nivel, raza, experiencia, Tamano.id, clase, Entidad.nombre;
`;

const entityQuery = `
SELECT Entidad.nombre, nivel, experiencia, alineacionId, Alineacion.nombre AS alineacion, Entidad.tamanoId,
Tamano.nombre AS tamano, razaId, Raza.nombre AS raza, claseId, Clase.nombre AS clase, Entidad.percepcion,
armaduraNatural + armaduraItem + Entidad.destreza + evasion as AC, armaduraNatural + armaduraItem as FFAC,
Entidad.salud, Entidad.fortaleza, Entidad.reflejos, Entidad.voluntad, Entidad.fuerza, Entidad.destreza,
Entidad.constitucion, Entidad.inteligencia, Entidad.sabiduria, Entidad.carisma, Entidad.acrobacia,
Entidad.atletismo, Entidad.fabricacion, Entidad.engano, Entidad.diplomacia, Entidad.intimidacion,
Entidad.tradicion, Entidad.medicina, Entidad.naturaleza, Entidad.ocultismo, Entidad.actuacion, Entidad.religion,
Entidad.sociedad, Entidad.sigilo, Entidad.supervivencia, Entidad.robo, dinero, tesoro, descripcion
FROM Entidad JOIN Clase ON Entidad.claseId = Clase.id
JOIN Alineacion ON Entidad.alineacionId = Alineacion.id
JOIN Tamano ON Entidad.tamanoId = Tamano.id
JOIN Raza ON Entidad.razaId = Raza.id
WHERE Entidad.id = ?;
`;

const entityCreate = `
INSERT INTO Entidad(nombre, descripcion, tesoro, nivel, experiencia, percepcion, armaduraNatural,
armaduraItem, evasion, salud, fortaleza, reflejos, voluntad, ataqueBase, fuerza, destreza, constitucion,
inteligencia, sabiduria, carisma, acrobacia, arcana, atletismo, fabricacion, engano, diplomacia, intimidacion,
tradicion, medicina, naturaleza, ocultismo, actuacion, religion, sociedad, sigilo, supervivencia, robo,
dinero, razaId, tamanoId, alineacionId, claseId)
VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
?, ?, ?, ?, ?, ?);
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
    const eQuery = await glosaryDatabase.query(entityQuery, [id]);
    const entity = eQuery[0];
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
    const spells = await getSpellsByEntity(id);
    entity.hechizos = spells;

    return entity;
  } catch (err) {
    console.error("error on load single entitiy:", err);
  }
}

export async function createEntity(entity) {
  try {
    //se crea la entidad como tal y se retorna el Id
    const entidadId = await glosaryDatabase.create(entityCreate, entity.getCreationVector());
    //se crea cada una de las relaciones muchos a muchos
    for(let i = 0; i < entity.traits.length; i++){
      await createTraitEntity(entity.traits[i], entidadId);
    };
    for(let i = 0; i < entity.abilities.length; i++){
      await createAbilityEntity(entity.abilities[i], entidadId);
    };
    for(let i = 0; i < entity.inmunities.length; i++){
      await createInmunityEntity(entity.inmunities[i], entidadId);
    };
    for(let i = 0; i < entity.languages.length; i++){
      await createLanguageEntity(entity.languages[i], entidadId);
    };
    for(let i = 0; i < entity.attacks.length; i++){
      await createAttackEntity(entidadId, entity.attacks[i]);
    };
    for(let i = 0; i < entity.spells.length; i++){
      await createSpellEntity(entidadId, entity.spells[i]);
    };
    for(let i = 0; i < entity.resistances.length; i++){
      await createResistanceEntity(entidadId, entity.resistances[i]);
    };
    for(let i = 0; i < entity.senses.length; i++){
      await createSenseEntity(entidadId, entity.senses[i]);
    };
    for(let i = 0; i < entity.movements.length; i++){
      await createMovementEntity(entidadId, entity.movements[i]);
    };
    return true;
  } catch (err) {
    console.error("error on create entity:", err);
    return false;
  }
}
