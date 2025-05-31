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

const abilityRaceQuery = `
SELECT Raza_Habilidad.habilidadId
FROM Raza_Habilidad
WHERE Raza_Habilidad.razaId = ?;
`;

export async function getAllAbilities() {
  try {
    return await glosaryDatabase.query(abilitiesQuery);
  } catch (err) {
    console.error("error on load all abilities:", err);
  }
}

const getTraitsByReference = async (id, query) => {
  const abilities = await glosaryDatabase.query(query, [id]);
  //se cargan también los razgos
  for (let i = 0; i < abilities.length; i++) {
    const traits = await getTraitByAbility(abilities[i].id);
    abilities[i].razgos = traits;
  }
  return abilities;
};

export async function getAbilitiesByEntity(id) {
  try {
    return await getTraitsByReference(id, abilityEntityQuery);
  } catch (err) {
    console.error("error on load abilities by entity:", err);
  }
}

export async function getAbilitiesByRace(id) {
  try {
    return await getTraitsByReference(id, abilityRaceQuery);
  } catch (err) {
    console.error("error on load abilities by race:", err);
  }
}
