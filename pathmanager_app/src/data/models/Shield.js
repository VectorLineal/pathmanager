import DeffenseItem from "./DeffenseItem";

export default class Shield extends DeffenseItem{
    constructor(nombre = '', nivel = 0, precio = 0, ac = 0, peso = 0, dureza = 0, salud = 0, velocidad = 0, efecto = null, fortaleza = 0, reflejos = 0, voluntad = 0){
        super(nombre, nivel, precio, ac, peso, velocidad, efecto, fortaleza, reflejos, voluntad);
        this.dureza = dureza;
        this.salud = salud;
    }
    getCreationVector(){
        return [this.nombre, this.nivel, this.precio, this.ac, this.peso, this.dureza, this.salud, this.velocidad, this.efecto, this.fortaleza, this.reflejos, this.voluntad];
    }
}