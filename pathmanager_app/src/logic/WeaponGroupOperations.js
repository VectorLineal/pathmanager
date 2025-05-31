import glosaryDatabase from "../data/services/DBPool";

const groupsQuery = `
SELECT * FROM Grupo order by nombre;
`;

export async function getAllWeaponGroups() {
  try {
    return await glosaryDatabase.query(groupsQuery);
  } catch (err) {
    console.error("error on load all weapon groups:", err);
  }
}