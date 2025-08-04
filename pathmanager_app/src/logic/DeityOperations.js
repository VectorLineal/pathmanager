import glosaryDatabase from "../data/services/DBPool";

const dietiesQuery = `
select id, nombre
FROM Deidad
ORDER BY nombre;
`;

const singleDeityQuery = `
select Deidad.nombre, edicto, anatema, simbolo, fuente, TipoDeidad.nombre AS categoria, atributoId, atAt.nombre AS atributo1,
atributoId2, atAt2.nombre AS atributo2, habilidadId, hab.nombre AS habilidad, armaId, Arma.nombre as arma, alineacionId, Alineacion.nombre as alineaicon
from Deidad join TipoDeidad on Deidad.tipoId = TipoDeidad.id
join Arma on Deidad.armaId = Arma.id
join Alineacion on Deidad.alineacionId = Alineacion.id
join Atributo as hab on Deidad.habilidadId = hab.id
left join Atributo as atAt on Deidad.atributoId = atAt.id
left join Atributo as atAt2 on Deidad.atributoId2 = atAt2.id
where Deidad.id = ?;
`;

export async function getAllDeities() {
  try {
    return await glosaryDatabase.query(dietiesQuery);
  } catch (err) {
    console.error("error on load all deities:", err);
  }
}

export async function getRaceById(id) {
  try {
    const dQuery = await glosaryDatabase.query(singleDeityQuery, [id]);
    const deity = dQuery[0];

    return deity;
  } catch (err) {
    console.error("error on load single deity:", err);
    return null;
  }
}