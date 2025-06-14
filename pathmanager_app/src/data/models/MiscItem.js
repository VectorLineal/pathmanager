import Item from "./Item";

export default class MiscItem extends Item{
    constructor(nombre = '', nivel = 0, precio = 0, peso = 0, efecto = null, tipoItem = null){
        super(nombre, nivel, precio, peso, efecto);
        this.tipoItem = tipoItem;
    }
    getCreationVector(){
        return [this.nombre, this.nivel, this.precio, this.peso, this.efecto, this.tipoItem];
    }
}