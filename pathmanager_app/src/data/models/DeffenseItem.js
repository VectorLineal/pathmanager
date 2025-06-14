import Item from "./Item";

export default class DeffenseItem extends Item{
    constructor(nombre = '', nivel = 0, precio = 0, ac = 0, peso = 0, velocidad = 0, efecto = null, fortaleza = 0, reflejos = 0, voluntad = 0){
        super(nombre, nivel, precio, peso, efecto);
        this.ac = ac;
        this.velocidad = velocidad;
        this.fortaleza = fortaleza;
        this.reflejos = reflejos;
        this.voluntad = voluntad;
    }
    getCreationVector(){
        return [this.nombre, this.nivel, this.precio, this.ac, this.peso, this.velocidad, this.efecto, this.fortaleza, this.reflejos, this.voluntad];
    }
}