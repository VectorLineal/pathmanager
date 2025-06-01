import glosaryDatabase from "../data/services/DBPool";

const featClassLevelQuery = `
SELECT nivel, nombre, requisito, descripcion, habilidadId
FROM Proeza JOIN Proeza_Clase ON Proeza.id = Proeza_Clase.proezaId
WHERE claseId = ? and nivel <= ?
ORDER BY nivel;
`;

export async function getFeatsByClassLevel(id, level) {
  try {
    return await glosaryDatabase.query(featClassLevelQuery, [id, level]);
  } catch (err) {
    console.error("error on load feats by class and level:", err);
  }
}
