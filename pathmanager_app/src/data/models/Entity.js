export default class Entity{
    constructor(name, level, xp, init, perception, naturalArmor, itemArmor, dodge, health, fort, reflex, will, attackBonus, str, dex, con, int, wis, cha, money, acrobatics, arcana, atletism, crafting, deceiving, diplomacy, intimidation, lore, medicine, nature, ocultism, performance, religion, society, stealth, survival, thievery){
        this.name = name;
        this.level = level;
        this.xp = xp;
        this.init = init;
        this.perception = perception;
        this.naturalArmor = naturalArmor;
        this.itemArmor = itemArmor;
        this.dodge = dodge;
        this.health = health;
        this.fort = fort;
        this.reflex = reflex;
        this.will = will;
        this.attackBonus = attackBonus;
        this.str = str;
        this.dex = dex;
        this.con = con;
        this.int = int;
        this.wis = wis;
        this.cha = cha;
        this.money = money;
        this.acrobatics = acrobatics;
        this.arcana = arcana;
        this.atletism = atletism;
        this.crafting = crafting;
        this.deceiving = deceiving;
        this.diplomacy = diplomacy;
        this.intimidation = intimidation;
        this.lore = lore;
        this.medicine = medicine;
        this.nature = nature;
        this.ocultism = ocultism;
        this.performance = performance;
        this.religion = religion;
        this.society = society;
        this.stealth = stealth;
        this.survival = survival;
        this.thievery = thievery;
    }

    getFlatFootedArmor(){
        return this.naturalArmor + this.itemArmor;
    }
    getArmor(){
        return this.getFlatFootedArmor() + this.dodge + this.dex;
    }
};