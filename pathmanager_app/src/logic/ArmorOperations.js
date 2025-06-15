import glosaryDatabase from "../data/services/DBPool";
import { getTraitByArmor, createTraitArmor } from "./TraitOperations";

const armorsQuery = `
SELECT id, nombre FROM Armadura order by nombre;
`;

const allArmorsQuery = `
SELECT Armadura.id, Armadura.nombre, nivel, precio, ac, peso, penalizacion, limite, requisito, velocidad,
efecto, fortaleza, reflejos, voluntad, Categoria.nombre AS categoria, Grupo.nombre AS grupo, especialidadCritico
FROM Armadura JOIN Categoria ON Armadura.categoriaId = Categoria.id 
JOIN Grupo ON Armadura.grupoId = Grupo.id
ORDER BY Armadura.nombre;
`;

const armorCreateQuery = `
INSERT INTO Armadura(nombre, nivel, precio, ac, peso, penalizacion, limite, requisito, velocidad, efecto, fortaleza, reflejos, voluntad, grupoId, categoriaId)
VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
`;

export async function getAllArmors() {
  try {
    return await glosaryDatabase.query(armorsQuery);
  } catch (err) {
    console.error("error on load all armors:", err);
  }
}

export async function getAllArmorsDisplay() {
  try {
    const armors = await glosaryDatabase.query(allArmorsQuery);
    for(let i = 0; i < armors.length; i++){
      const armorId = armors[i].id
      const traits = await getTraitByArmor(armorId);
      armors[i].razgos = traits;
    }
    return armors;
  } catch (err) {
    console.error("error on load all armors:", err);
  }
}

export async function createArmor(armor) {
  try {
    //se crea el hechizo como tal y se retorna el Id
    const armaduraId = await glosaryDatabase.create(armorCreateQuery, armor.getCreationVector());
    console.log("completed armor transaction:", armaduraId);
    //se crea cada una de las relaciones muchos a muchos
    for(let i = 0; i < armor.traits.length; i++){
      await createTraitArmor(armor.traits[i], armaduraId);
    };
    return true;
  } catch (err) {
    console.error("error on create armor:", err);
    return false;
  }
}