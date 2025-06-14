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

const traitEntityCreate = `
INSERT INTO Razgo_Entidad(razgoId, entidadId) VALUES(?, ?);
`;

const traitSpellCreate = `
INSERT INTO Razgo_Hechizo(razgoId, hechizoId) VALUES(?, ?);
`;
const traitWeaponCreate = `
INSERT INTO Razgo_Arma(razgoId, armaId, monto) VALUES(?, ?, ?);
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

export async function createTraitEntity(trait, entity) {
  try {
    return await glosaryDatabase.create(traitEntityCreate, [trait, entity]);
  } catch (err) {
    console.error("error on create trait entity:", err);
  }
}

export async function createTraitSpell(trait, spell) {
  try {
    return await glosaryDatabase.create(traitSpellCreate, [trait, spell]);
  } catch (err) {
    console.error("error on create trait spell:", err);
  }
}

export async function createTraitWeapon(trait, weapon, amount) {
  try {
    return await glosaryDatabase.create(traitWeaponCreate, [trait, weapon, amount]);
  } catch (err) {
    console.error("error on create trait spell:", err);
  }
}