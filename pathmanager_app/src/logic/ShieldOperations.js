import glosaryDatabase from "../data/services/DBPool";
import { getTraitByShield, createTraitShield } from "./TraitOperations";

const shieldsQuery = `
SELECT id, nombre FROM Escudo order by nombre;
`;

const allShieldsQuery = `
SELECT Escudo.id, Escudo.nombre, nivel, precio, ac, peso, dureza, salud, velocidad, efecto, fortaleza, reflejos, voluntad
FROM Escudo
ORDER BY Escudo.nombre;
`;

const shieldCreateQuery = `
INSERT INTO Escudo(nombre, nivel, precio, ac, peso, dureza, salud, velocidad, efecto, fortaleza, reflejos, voluntad)
VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
`;

export async function getAllShields() {
  try {
    return await glosaryDatabase.query(shieldsQuery);
  } catch (err) {
    console.error("error on load all shields:", err);
  }
}

export async function getAllShieldsDisplay() {
  try {
    const shields = await glosaryDatabase.query(allShieldsQuery);
    for(let i = 0; i < shields.length; i++){
      const shieldId = shields[i].id
      const traits = await getTraitByShield(shieldId);
      shields[i].razgos = traits;
    }
    return shields;
  } catch (err) {
    console.error("error on load all shields:", err);
  }
}

export async function createShield(shield) {
  try {
    //se crea el hechizo como tal y se retorna el Id
    const escudoId = await glosaryDatabase.create(shieldCreateQuery, shield.getCreationVector());
    console.log("completed shield transaction:", escudoId);
    //se crea cada una de las relaciones muchos a muchos
    for(let i = 0; i < shield.traits.length; i++){
      await createTraitShield(shield.traits[i].id, escudoId, shield.traits[i].monto);
    };
    return true;
  } catch (err) {
    console.error("error on create shield:", err);
    return false;
  }
}