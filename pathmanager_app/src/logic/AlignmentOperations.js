import glosaryDatabase from "../data/services/DBPool";

const alignmentsQuery = `
SELECT * FROM Alineacion;
`;
const alignmentMatrix = [[5, 2, 8], [4, 1, 7], [6, 3, 9]];

export function getGood(){
  return alignmentMatrix[0];
}
export function getEvil(){
  return alignmentMatrix[2];
}
function getCoords(alignment){
  for(let i = 0; i < alignmentMatrix.length; i++){
    const row = alignmentMatrix[i];
    for(let j = 0; j < row.length; j++){
      if(row[j] == alignment) return {i, j};
    }
  }
  //valor por defecto neutral
  return {i: 1, j: 1};
}
export function getAdyacentAlignments(alignment){
  const baseAlignment = (alignment > 0 && alignment <= 9)? alignment: 1;
  const {i, j} = getCoords(baseAlignment);
  const adyacent = [baseAlignment];
  const deltaI = [];
  const deltaJ = [];
  const iMax = alignmentMatrix.length - 1;
  const jMax = alignmentMatrix[0].length - 1;
  if(i == 0) deltaI.push(1);
  else if(i == iMax) deltaI.push(-1);
  else{
    deltaI.push(1);
    deltaI.push(-1);
  }
  if(j == 0) deltaJ.push(1);
  else if(j == jMax) deltaJ.push(-1);
  else{
    deltaJ.push(1);
    deltaJ.push(-1);
  }
  for(let k = 0; k < deltaI.length; k++){
    adyacent.push(alignmentMatrix[i + deltaI[k]][j]);
  }
  for(let l = 0; l < deltaJ.length; l++){
    adyacent.push(alignmentMatrix[i][j + deltaJ[l]]);
  }
  return adyacent;
}

export async function getAllAlignments() {
  try {
    return await glosaryDatabase.query(alignmentsQuery);
  } catch (err) {
    console.error("error on load all alignments:", err);
  }
}
