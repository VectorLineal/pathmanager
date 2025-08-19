import glosaryDatabase from "../data/services/DBPool";
import { getTraitByAbility } from "./TraitOperations";

const abilitiesQuery = `
SELECT id, nombre
FROM HabilidadEspecial
ORDER BY nombre;
`;

const abilityEntityQuery = `
select HabilidadEspecial.id, nombre, efecto, requisito, critico, demora, alcance
FROM Habilidad_Entidad JOIN HabilidadEspecial ON HabilidadEspecial.id = Habilidad_Entidad.habilidadId
WHERE Habilidad_Entidad.entidadId = ?
order by HabilidadEspecial.nombre;
`;

const abilitySubclassLevelQuery = `
select HabilidadEspecial.id, nombre, efecto, requisito, critico, demora, alcance
FROM SubclaseNivel_Habilidad JOIN HabilidadEspecial ON SubclaseNivel_Habilidad.habilidadId = HabilidadEspecial.id
WHERE subclaseId = ? and nivel = ?
order by HabilidadEspecial.nombre;
`;

const abilityClassLevelQuery = `
select HabilidadEspecial.id, nombre, efecto, requisito, critico, demora, alcance
FROM ClaseNivel_Habilidad JOIN HabilidadEspecial ON ClaseNivel_Habilidad.habilidadId = HabilidadEspecial.id
WHERE claseId = ? and nivel = ?
order by HabilidadEspecial.nombre;
`;

const abilityRaceQuery = `
SELECT Raza_Habilidad.habilidadId
FROM Raza_Habilidad
WHERE Raza_Habilidad.razaId = ?;
`;

const abilityEntityCreate = `
INSERT INTO Habilidad_Entidad(habilidadId, entidadId) VALUES(?, ?);
`;

export async function getAllAbilities() {
  try {
    return await glosaryDatabase.query(abilitiesQuery);
  } catch (err) {
    console.error("error on load all abilities:", err);
  }
}

const getTraitsByReference = async (params, query) => {
  const abilities = await glosaryDatabase.query(query, params);
  //se cargan también los razgos
  for (let i = 0; i < abilities.length; i++) {
    const traits = await getTraitByAbility(abilities[i].id);
    abilities[i].razgos = traits;
  }
  return abilities;
};

export async function getAbilitiesByEntity(id) {
  try {
    return await getTraitsByReference([id], abilityEntityQuery);
  } catch (err) {
    console.error("error on load abilities by entity:", err);
  }
}

export async function getAbilitiesBySubclassLevel(id, level) {
  try {
    return await getTraitsByReference([id, level], abilitySubclassLevelQuery);
  } catch (err) {
    console.error("error on load abilities by subclass and level:", err);
  }
}

export async function getAbilitiesByClassLevel(id, level) {
  try {
    return await getTraitsByReference([id, level], abilityClassLevelQuery);
  } catch (err) {
    console.error("error on load abilities by class and level:", err);
  }
}

export async function getAbilitiesByRace(id) {
  try {
    return await getTraitsByReference([id], abilityRaceQuery);
  } catch (err) {
    console.error("error on load abilities by race:", err);
  }
}

export async function createAbilityEntity(ability, entity) {
  try {
    return await glosaryDatabase.create(abilityEntityCreate, [ability, entity]);
  } catch (err) {
    console.error("error on create ability entity:", err);
  }
}