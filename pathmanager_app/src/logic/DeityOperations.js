import glosaryDatabase from "../data/services/DBPool";
import {getGood, getEvil} from "./AlignmentOperations";
import { getDomainsByDeity } from "./DomainOperaions";
import { makeOptions } from "./utilities/StructureUtils";

const dietiesQuery = `
select id, nombre
FROM Deidad
ORDER BY nombre;
`;

const alignedDietiesQuery = `
select id, nombre
FROM Deidad
WHERE alineacionId in (?, ?, ?)
ORDER BY nombre;
`;

const singleDeityQuery = `
select Deidad.nombre, edicto, anatema, simbolo, fuente, TipoDeidad.nombre AS categoria, atributoId,
atAt.nombre AS atributo1, atributoId2, atAt2.nombre AS atributo2, habilidadId, hab.nombre AS habilidad,
armaId, Arma.nombre as arma, alineacionId, Alineacion.nombre as alineaicon
from Deidad join TipoDeidad on Deidad.tipoId = TipoDeidad.id
join Arma on Deidad.armaId = Arma.id
join Alineacion on Deidad.alineacionId = Alineacion.id
join Atributo as hab on Deidad.habilidadId = hab.id
left join Atributo as atAt on Deidad.atributoId = atAt.id
left join Atributo as atAt2 on Deidad.atributoId2 = atAt2.id
where Deidad.id = ?;
`;

export async function getAllAlignedDeities(alignment = 0) {
  try {
    switch(alignment){
      case -1:
        return await glosaryDatabase.query(alignedDietiesQuery, getEvil());
      case 0:
      default:
        return await glosaryDatabase.query(dietiesQuery);
      case 1:
        return await glosaryDatabase.query(alignedDietiesQuery, getGood());
    }
  } catch (err) {
    console.error("error on load all deities:", err);
  }
}
export async function getDeityOptions(alignment = 0) {
  const results = await getAllAlignedDeities(alignment);
  return makeOptions(results);
}

export async function getDeityById(id) {
  try {
    const dQuery = await glosaryDatabase.query(singleDeityQuery, [id]);
    const deity = dQuery[0];
    const domains = await getDomainsByDeity(id);
    deity.dominios = domains;

    return deity;
  } catch (err) {
    console.error("error on load single deity:", err);
    return null;
  }
}

function mapFontType(font){
  return font === -1? 'Impía' : (font === 0? 'Cualquiera' : 'Sagrada');
}
function mapDomains(domains){
  const dText = "";
  for(let i = 0; i < domains.length; i++){
    const domain = domains[i].nombre;
    dText += domain + (i < domains.length - 1? ', ' : '');
  }
  return dText;
}

export function getDeityDataVector(data) {
  const attributeText = (data.atributo1 == null && data.atributo2 == null)? 'cualquiera': (data.atributo1 + (data.atributo2 != null? ' o ' + data.atributo2:''));
  const descriptions =  [
    {value: data.edicto, label: 'Edicto'},
    {value: data.anatema == null? '': data.anatema, label: 'Anatema'},
    {value: data.alineaicon, label: 'Alineación'},
    {value: mapFontType(data.categoria), label: 'Tipo de deidad'},
    {value: mapFontType(data.fuente), label: 'Fuente'},
    {value: data.arma, label: 'Arma Favorecida'},
    {value: data.habilidad, label: 'Habilidad Divina'},
    {value: attributeText, label: 'Atributo Divino'},
    {value: mapDomains(data.dominios), label: 'Dominios'}
  ];

  return descriptions;
}
