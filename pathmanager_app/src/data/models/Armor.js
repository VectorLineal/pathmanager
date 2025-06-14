import DeffenseItem from "./DeffenseItem";

export default class Armor extends DeffenseItem{
    constructor(nombre = '', nivel = 0, precio = 0, ac = 0, peso = 0, penalizacion = 0, limite = 5, requisito = 0, velocidad = 0, efecto = null, fortaleza = 0, reflejos = 0, voluntad = 0, grupoId = null, categoriaId = null){
        super(nombre, nivel, precio, ac, peso, velocidad, efecto, fortaleza, reflejos, voluntad);
        this.penalizacion = penalizacion;
        this.limite = limite;
        this.requisito = requisito;
        this.grupoId = grupoId;
        this.categoriaId = categoriaId;
    }
    getCreationVector(){
        return [this.nombre, this.nivel, this.precio, this.ac, this.peso, this.penalizacion, this.limite, this.requisito, this.velocidad, this.efecto, this.fortaleza, this.reflejos, this.voluntad, this.grupoId, this.categoriaId];
    }
}