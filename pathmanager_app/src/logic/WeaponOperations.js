import glosaryDatabase from "../data/services/DBPool";
import { getTraitByWeapon, createTraitWeapon } from "./TraitOperations";

const weaponsQuery = `
SELECT id, nombre FROM Arma order by nombre;
`;

const allWeaponsQuery = `
SELECT Arma.id, Arma.nombre, precio, nivel, manos, peso, monto, alcance, bono, efecto,
TipoDano.nombre as tipoDano, Tipo.nombre AS tipo, Grupo.nombre as grupo, Categoria.nombre as categoria,
Grupo.especialidadCritico
FROM Arma JOIN Grupo ON Arma.grupoId = Grupo.id
JOIN Tipo ON Arma.tipoId = Tipo.id
JOIN Categoria ON Arma.categoriaId = Categoria.id 
JOIN TipoDano ON Arma.danoId = TipoDano.id
ORDER BY Arma.nombre;
`;

const weaponAttackQuery = `
SELECT monto, alcance, efecto, bono, danoId
FROM Arma
WHERE id = ?;
`;
const weaponCreateQuery = `
INSERT INTO Arma(nombre, nivel, precio, manos, peso, monto, alcance, bono, efecto, danoId, tipoId, grupoId, categoriaId)
VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
`;

export async function getAllWeapons() {
  try {
    return await glosaryDatabase.query(weaponsQuery);
  } catch (err) {
    console.error("error on load all weapons:", err);
  }
}

export async function getAllWeaponsDisplay() {
  try {
    const weapons = await glosaryDatabase.query(allWeaponsQuery);
    for(let i = 0; i < weapons.length; i++){
      const weaponId = weapons[i].id
      const traits = await getTraitByWeapon(weaponId);
      weapons[i].razgos = traits;
    }
    return weapons;
  } catch (err) {
    console.error("error on load all weapons:", err);
  }
}

export async function getWeaponBaseAttack(id) {
  try {
    const baseAttack = await glosaryDatabase.query(weaponAttackQuery, [id]);
    return baseAttack[0];
  } catch (err) {
    console.error("error on load weapon's attack:", err);
  }
}

export async function createWeapon(weapon) {
  try {
    //se crea el hechizo como tal y se retorna el Id
    const armaId = await glosaryDatabase.create(weaponCreateQuery, weapon.getCreationVector());
    console.log("completed weapon transaction:", armaId);
    //se crea cada una de las relaciones muchos a muchos
    for(let i = 0; i < weapon.traits.length; i++){
      await createTraitWeapon(weapon.traits[i].id, armaId, weapon.traits[i].monto);
    };
    return true;
  } catch (err) {
    console.error("error on create weapon:", err);
    return false;
  }
}