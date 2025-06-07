import Item from "./Item";

export default class Weapon extends Item{
    constructor(nombre = '', nivel = 0, precio = 0, manos = 1, peso = 0, monto = '1d4', alcance = 1, bono = 0, efecto = null, danoId = null, tipoId = null, grupoId = null, categoriaId = null){
        super(nombre, nivel, precio, peso, efecto);
        this.manos = manos;
        this.monto = monto;
        this.alcance = alcance;
        this.bono = bono;
        this.danoId = danoId;
        this.tipoId = tipoId;
        this.grupoId = grupoId;
        this.categoriaId = categoriaId;
    }
    getCreationVector(){
        return [this.nombre, this.nivel, this.precio, this.manos, this.peso, this.monto, this.alcance, this.bono, this.efecto, this.danoId, this.tipoId, this.grupoId, this.categoriaId];
    }
}