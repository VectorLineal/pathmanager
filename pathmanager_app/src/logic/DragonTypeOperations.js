import glosaryDatabase from "../data/services/DBPool";

const dragonTypesQuery = `
SELECT TipoDragon.id, TipoDragon.nombre || ' (' || Tradicion.nombre || ') aliento: ' || TipoDano.nombre || '(' || IIF(salvacion = 7, 'R', IIF(salvacion = 8, 'F', 'V')) || ')' AS nombre
FROM TipoDragon JOIN Tradicion ON TipoDragon.tradicionId = Tradicion.id
JOIN TipoDano ON TipoDano.id = TipoDragon.danoId
JOIN Atributo on TipoDragon.salvacion = Atributo.id
order by TipoDragon.nombre;
`;
const dragonTraditionByIdQuery = `
SELECT tradicionId
FROM TipoDragon
WHERE id = ?;
`;

export async function getAllDragonTypes() {
  try {
    return await glosaryDatabase.query(dragonTypesQuery);
  } catch (err) {
    console.error("error on load all dragon types:", err);
  }
}
export async function getDragonTraditionById(id) {
  try {
    const response = await glosaryDatabase.query(dragonTraditionByIdQuery, [id]);
    //por defecto, si no se encuentra nada, se selecciona escuela arcana
    if(response.length == 0) return 1;
    else return response[0].tradicionId;
  } catch (err) {
    console.error("error on load dragon spell tradition:", err);
  }
}
