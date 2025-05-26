import glosaryDatabase from "../data/services/DBPool";

const allTraitsQuery = `
SELECT * FROM Razgo ORDER BY nombre;
`;

const traitsEntityQuery = `
SELECT Razgo.id, Razgo.nombre, Razgo.descripcion
FROM Razgo_Entidad JOIN Razgo ON Razgo.id = Razgo_Entidad.razgoId
WHERE Razgo_Entidad.entidadId = ?
ORDER BY Razgo.nombre;
`;
const traitsSpellQuery = `
SELECT Razgo.id, Razgo.nombre, Razgo.descripcion
FROM Razgo_Hechizo JOIN Razgo ON Razgo.id = Razgo_Hechizo.razgoId
WHERE Razgo_Hechizo.hechizoId = ?
ORDER BY Razgo.nombre;
`;
const traitsAbilityQuery = `
SELECT Razgo.id, Razgo.nombre, Razgo.descripcion
FROM Razgo_Habilidad JOIN Razgo ON Razgo.id = Razgo_Habilidad.razgoId
WHERE Razgo_Habilidad.habilidadId = ?
ORDER BY Razgo.nombre;
`;
const traitsWeaponQuery = `
SELECT Razgo.id, Razgo.nombre, Razgo.descripcion, Razgo_Arma.monto
FROM Razgo_Arma JOIN Razgo ON Razgo.id = Razgo_Arma.razgoId
WHERE Razgo_Arma.armaId = ?
ORDER BY Razgo.nombre;
`;

export async function getAllTraits() {
  try {
    return await glosaryDatabase.query(allTraitsQuery);
  } catch (err) {
    console.error("error on load all traits:", err);
  }
}

export async function getTraitByEntity(id) {
  try {
    return await glosaryDatabase.query(traitsEntityQuery, [id]);
  } catch (err) {
    console.error("error on load traits by entity:", err);
  }
}
export async function getTraitBySpell(id) {
  try {
    return await glosaryDatabase.query(traitsSpellQuery, [id]);
  } catch (err) {
    console.error("error on load traits by spell:", err);
  }
}
export async function getTraitByAbility(id) {
  try {
    return await glosaryDatabase.query(traitsAbilityQuery, [id]);
  } catch (err) {
    console.error("error on load traits by ability:", err);
  }
}
export async function getTraitByWeapon(id) {
  try {
    return await glosaryDatabase.query(traitsWeaponQuery, [id]);
  } catch (err) {
    console.error("error on load traits by weapon:", err);
  }
}
