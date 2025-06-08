import Item from "./Item";

export default class Armor extends Item{
    constructor(nombre = '', nivel = 0, precio = 0, ac = 0, peso = 0, penalizacion = 0, limite = 0, requisito = 5, velocidad = 0, efecto = null, grupoId = null, categoriaId = null){
        super(nombre, nivel, precio, peso, efecto);
        this.ac = ac;
        this.penalizacion = penalizacion;
        this.limite = limite;
        this.requisito = requisito;
        this.velocidad = velocidad;
        this.grupoId = grupoId;
        this.categoriaId = categoriaId;
    }
    getCreationVector(){
        return [this.nombre, this.nivel, this.precio, this.ac, this.peso, this.penalizacion, this.limite, this.requisito, this.velocidad, this.efecto, this.grupoId, this.categoriaId];
    }
}