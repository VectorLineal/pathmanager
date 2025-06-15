import glosaryDatabase from "../data/services/DBPool";
import { getTraitByMiscItem, createTraitMiscItem } from "./TraitOperations";
import { createAtributeByItem } from "./AttributeOperations";

const miscItemsQuery = `
SELECT id, nombre FROM ItemMiscelaneo ¿ order by nombre;
`;

const allMiscItemsQuery = `
SELECT ItemMiscelaneo.id, ItemMiscelaneo.nombre, nivel, precio, peso, efecto, TipoItem.nombre AS tipo
FROM ItemMiscelaneo JOIN TipoItem ON ItemMiscelaneo.categoriaId = TipoItem.id
¿
ORDER BY ItemMiscelaneo.nombre;
`;

const miscItemCreateQuery = `
INSERT INTO ItemMiscelaneo(nombre, nivel, precio, peso, efecto, tipoId)
VALUES(?, ?, ?, ?, ?, ?);
`;

const apparealFilter = 'WHERE tipoId >= 4 AND tipoId <= 8';
const consumableFilter = 'WHERE tipoId >= 9 AND tipoId <= 11';
const artifactFilter = 'WHERE tipoId >= 12 AND tipoId <= 13';

const getFilter = (code) => {
    switch(code){
        case 0:
        default:
            return apparealFilter;
        case 1:
            return consumableFilter;
        case 2:
            return artifactFilter;
    }
}

export async function getAllMiscItems(itemSet) {
    const filter = getFilter(itemSet);
  try {
    return await glosaryDatabase.query(miscItemsQuery.replace('¿', filter));
  } catch (err) {
    console.error("error on load all misc Items:", err);
  }
}

export async function getAllMiscItemsDisplay(itemSet) {
    const filter = getFilter(itemSet);
  try {
    const miscItems = await glosaryDatabase.query(allMiscItemsQuery.replace('¿', filter));
    for(let i = 0; i < miscItems.length; i++){
      const miscItemId = miscItems[i].id
      const traits = await getTraitByMiscItem(miscItemId);
      miscItems[i].razgos = traits;
    }
    return miscItems;
  } catch (err) {
    console.error("error on load all misc Items:", err);
  }
}

export async function createMiscItem(miscItem) {
  try {
    //se crea el hechizo como tal y se retorna el Id
    const itemMiscId = await glosaryDatabase.create(miscItemCreateQuery, miscItem.getCreationVector());
    console.log("completed miscItem transaction:", itemMiscId);
    //se crea cada una de las relaciones muchos a muchos
    for(let i = 0; i < miscItem.traits.length; i++){
      await createTraitMiscItem(miscItem.traits[i], itemMiscId);
    }
    for(let i = 0; i < miscItem.attributes.length; i++){
      await createAtributeByItem(itemMiscId, miscItem.attributes[i].id, miscItem.attributes[i].cantidad);
    }
    return true;
  } catch (err) {
    console.error("error on create misc Item:", err);
    return false;
  }
}