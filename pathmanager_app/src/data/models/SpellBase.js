export default class SpellBase{
    constructor(nombre, fallo, efecto, critico, demora, nivel, alcance, aumentos, escuelaId, blancoId){
        this.nombre = nombre;
        this.fallo = fallo;
        this.efecto = efecto;
        this.critico = critico;
        this.demora = demora;
        this.nivel = nivel;
        this.alcance = alcance;
        this.aumentos = aumentos;
        this.escuelaId = escuelaId;
        this.blancoId = blancoId;
        this.traits = [];
    }

    getCreationVector(){
        return [this.nombre, this.fallo, this.efecto, this.critico, this.demora, this.nivel, this.alcance, this.aumentos, this.escuelaId, this.blancoId];
    }
}