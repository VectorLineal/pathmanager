import SpellBase from "./SpellBase";

export default class FocusSpell extends SpellBase{
    constructor(nombre = '', fallo = null, efecto = '', critico = null, demora = 2, nivel = 0, alcance = 0, aumentos = null, claseId = null, escuelaId = null, blancoId = null){
        super(nombre, fallo, efecto, critico, demora, nivel, alcance, aumentos, escuelaId, blancoId);
        this.claseId = claseId;
    }
    getCreationVector(){
        return [this.nombre, this.fallo, this.efecto, this.critico, this.demora, this.nivel, this.alcance, this.aumentos, this.claseId, this.escuelaId, this.blancoId];
    }
}