import glosaryDatabase from "../data/services/DBPool";
import { getTraitByWeapon } from "./TraitOperations";

const attackEntityQuery = `
SELECT Arma.id, Arma.nombre, Ataque.bono + Entidad.ataqueBase AS bono_ataque, Ataque.alcance,
TipoDano.nombre AS tipo_dano, Ataque.monto, Ataque.efecto
FROM Entidad JOIN Ataque ON Ataque.entidadId = Entidad.id
JOIN TipoDano ON Ataque.danoId = TipoDano.id
JOIN Arma ON Arma.id = Ataque.armaId
WHERE Entidad.id = ?
order by Arma.nombre;
`;

const createAttackEntityQuery = `
INSERT INTO Ataque(entidadId, armaId, monto, alcance, efecto, bono, danoId)
VALUES(?, ?, ?, ?, ?, ?, ?);
`;

export async function getAttacksByEntity(id) {
  try {
    const attacks = await glosaryDatabase.query(attackEntityQuery, [id]);
    //se cargan también los razgos
    for(let i = 0; i < attacks.length; i++){
      const traits = await getTraitByWeapon(attacks[i].id);
      attacks[i].razgos = traits;
    }
    return attacks;
  } catch (err) {
    console.error("error on load attacks by entity:", err);
  }
}

export async function createAttackEntity(entity, attack) {
  try {
    return await glosaryDatabase.create(createAttackEntityQuery,
      [entity, attack.armaId, attack.monto, attack.alcance, attack.efecto, attack.bono, attack.danoId]
    );
  } catch (err) {
    console.error("error on create attack entity:", err);
  }
}