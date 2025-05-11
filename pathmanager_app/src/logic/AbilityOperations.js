import glosaryDatabase from "../data/services/DBPool";
import { getTraitByAbility } from "./TraitOperations";

const abilityEntityQuery = `
select HabilidadEspecial.id, nombre, efecto, requisito, critico, demora, alcance
FROM Habilidad_Entidad JOIN HabilidadEspecial ON HabilidadEspecial.id = Habilidad_Entidad.habilidadId
WHERE Habilidad_Entidad.entidadId = ?
order by HabilidadEspecial.nombre;
`;

export async function getAbilitiesByEntity(id) {
  try {
    const abilities = await glosaryDatabase.query(abilityEntityQuery, [id]);
    //se cargan también los razgos
    for(let i = 0; i < abilities.length; i++){
      const traits = await getTraitByAbility(abilities[i].id);
      abilities[i].razgos = traits;
    }
    return abilities;
  } catch (err) {
    console.error("error on load abilities by entity:", err);
  }
}
