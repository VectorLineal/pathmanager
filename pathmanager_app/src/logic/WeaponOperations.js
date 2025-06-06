import glosaryDatabase from "../data/services/DBPool";

const weaponsQuery = `
SELECT id, nombre FROM Arma order by nombre;
`;

const weaponAttackQuery = `
SELECT monto, alcance, efecto, bono, danoId
FROM Arma
WHERE id = ?;
`;

export async function getAllWeapons() {
  try {
    return await glosaryDatabase.query(weaponsQuery);
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