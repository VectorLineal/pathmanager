import SpellBase from "./SpellBase";

export default class Spell extends SpellBase{
    constructor(nombre = '', fallo = null, efecto = '', critico = null, demora = 2, nivel = 0, alcance = 0, aumentos = null, escuelaId = null, blancoId = null){
        super(nombre, fallo, efecto, critico, demora, nivel, alcance, aumentos, escuelaId, blancoId);
        this.traditions = [];
    }
}