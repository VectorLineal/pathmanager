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
const traitsArmorQuery = `
SELECT Razgo.id, Razgo.nombre, Razgo.descripcion
FROM Razgo_Armadura JOIN Razgo ON Razgo.id = Razgo_Armadura.razgoId
WHERE Razgo_Armadura.armaduraId = ?
ORDER BY Razgo.nombre;
`;
const traitsShieldQuery = `
SELECT Razgo.id, Razgo.nombre, Razgo.descripcion, Razgo_Escudo.monto
FROM Razgo_Escudo JOIN Razgo ON Razgo.id = Razgo_Escudo.razgoId
WHERE Razgo_Escudo.escudoId = ?
ORDER BY Razgo.nombre;
`;
const traitsMiscItemQuery = `
SELECT Razgo.id, Razgo.nombre, Razgo.descripcion
FROM Razgo_Item JOIN Razgo ON Razgo.id = Razgo_Item.razgoId
WHERE Razgo_Item.itemId = ?
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
const traitArmorCreate = `
INSERT INTO Razgo_Armadura(razgoId, armaduraId) VALUES(?, ?);
`;
const traitShieldCreate = `
INSERT INTO Razgo_Escudo(razgoId, escudoId, monto) VALUES(?, ?, ?);
`;
const traitMiscItemCreate = `
INSERT INTO Razgo_Item(razgoId, itemId) VALUES(?, ?);
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
export async function getTraitByArmor(id) {
  try {
    return await glosaryDatabase.query(traitsArmorQuery, [id]);
  } catch (err) {
    console.error("error on load traits by armor:", err);
  }
}
export async function getTraitByShield(id) {
  try {
    return await glosaryDatabase.query(traitsShieldQuery, [id]);
  } catch (err) {
    console.error("error on load traits by shield:", err);
  }
}
export async function getTraitByMiscItem(id) {
  try {
    return await glosaryDatabase.query(traitsMiscItemQuery, [id]);
  } catch (err) {
    console.error("error on load traits by misc item:", err);
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
    console.error("error on create trait weapon:", err);
  }
}

export async function createTraitArmor(trait, armor) {
  try {
    return await glosaryDatabase.create(traitArmorCreate, [trait, armor]);
  } catch (err) {
    console.error("error on create trait armor:", err);
  }
}
export async function createTraitShield(trait, shield, amount) {
  try {
    return await glosaryDatabase.create(traitShieldCreate, [trait, shield, amount]);
  } catch (err) {
    console.error("error on create trait shield:", err);
  }
}
export async function createTraitMiscItem(trait, item) {
  try {
    return await glosaryDatabase.create(traitMiscItemCreate, [trait, item]);
  } catch (err) {
    console.error("error on create trait misc item:", err);
  }
}