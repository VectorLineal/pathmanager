export default class Item{
    constructor(nombre = '', nivel = 0, precio = 0, peso = 0, efecto = null){
        this.nombre = nombre
        this.nivel = nivel;
        this.precio = precio;
        this.peso = peso;
        this.efecto = efecto;
        this.traits = [];
    }
    getCreationVector(){
        return [this.nombre, this.nivel, this.precio, this.peso, this.efecto];
    }
}