/**
 * @typedef {Object} RarityQuery
 * @property {string} nombre
 * @property {number} id
 * @property {string} rareza
 */
/**
 * @typedef {Object} BasicQuery
 * @property {string} nombre
 * @property {number} id
 */
/**
 * @typedef {Object} Option
 * @property {string} label
 * @property {number} value
 */
/**
 * @typedef {Object} LabeledOptions
 * @property {string} label
 * @property {Array<Option>} options
 */
/**
 * Transforma un query con rareza en opciones marcadas (la lista debe ir ordenada por rareza)
 * @param {Array<RarityQuery>} data 
 * @returns {Array<LabeledOptions>}
 */
export function makeLabeledOptions(data) {
  const labeledOptions = [];
  let curLabel = '';
  let curIndex = 0;
  //se toma en cuenta que los resultados del query van ordenados por rareza
  data.forEach(entry => {
    const option = {
      value: entry.id,
      label: entry.nombre
    }
    if(entry.rareza != curLabel){
      curLabel = entry.rareza;
      labeledOptions.push({
        label: curLabel,
        options: [option]
      });
      //siempre se va a manipular la última opción
      curIndex = labeledOptions.length - 1;
    }else{
      labeledOptions[curIndex].options.push(option);
    }
  });
  return labeledOptions;
}
/**
 * Transforma un query con rareza en opciones marcadas (la lista debe ir ordenada por rareza)
 * @param {Array<BasicQuery>} data 
 * @returns {Array<Option>}
 */
export function makeOptions(data) {
  const options = [];
  data.forEach(entry => {
    const option = { value: entry.id, label: entry.nombre }
    options.push(option);
  });
  return options;
}
/**
 * Determina si el id es uno de los value contenidos en la lista de opciones
 * @param {Number} id 
 * @param {Array<Option>} data 
 * @returns {Boolean}
 */
export function hasValueOption(id, data) {
  for(let i = 0; i < data.length; i++){
    if(data[i].value == id) return true;
  }
  return false;
}