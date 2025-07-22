import Character from "./Character";

export default class Player extends Character{
    constructor(name = '', level = 1, description = '', perception = 0, unarmoredArmor = 0, lightArmor = 0, mediumArmor = 0, heavyArmor = 0, classDC = 0, spellDC = 0, health = 10, fort = 0, reflex = 0, will = 0, naturalAttack = 0, simpleAttack = 0, martialAttack = 0, str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0, money = 0, acrobatics = 0, arcana = 0, atletism = 0, crafting = 0, deceiving = 0, diplomacy = 0, intimidation = 0, medicine = 0, nature = 0, ocultism = 0, performance = 0, religion = 0, society = 0, stealth = 0, survival = 0, thievery = 0, portrait = '', classId = null, subclassId = null, subclassId2 = null, heritageId = null, alignmentId = null, sizeId = null, attributeId = null, backgroundId = null){
        super(name, level, description, perception, health, fort, reflex, will, str, dex, con, int, wis, cha, money, acrobatics, arcana, atletism, crafting, deceiving, diplomacy, intimidation, medicine, nature, ocultism, performance, religion, society, stealth, survival, thievery, classId, alignmentId, sizeId);
        this.xp = this.calculateXp();
        this.unarmoredArmor = unarmoredArmor;
        this.lightArmor = lightArmor;
        this.mediumArmor = mediumArmor;
        this.heavyArmor = heavyArmor;
        this.classDC = classDC;
        this.subclassId = subclassId;
        this.subclassId2 = subclassId2;
        this.spellDC = spellDC;
        this.naturalAttack = naturalAttack;
        this.simpleAttack = simpleAttack;
        this.martialAttack = martialAttack;
        this.portrait = portrait;
        this.heritageId = heritageId;
        this.attributeId = attributeId;
        this.backgroundId = backgroundId;
        this.lores = [];
        this.inventory = [];
    }
    getFlatFootedArmor(){
        return this.unarmoredArmor + this.lightArmor;
    }
    getArmor(){
        return this.getFlatFootedArmor() + this.mediumArmor + this.dex;
    }
    getCreationVector(){
        return [this.name, this.description, this.level, this.xp, this.perception, this.unarmoredArmor,
            this.lightArmor, this.mediumArmor, this.heavyArmor, this.classDC, this.spellDC, this.health, this.fort, this.reflex, this.will, this.naturalAttack, this.simpleAttack, this.martialAttack,
            this.str, this.dex, this.con, this.int, this.wis, this.cha, this.acrobatics, this.arcana, this.atletism,
            this.crafting, this.deceiving, this.diplomacy, this.intimidation, this.medicine, this.nature,
            this.ocultism, this.performance, this.religion, this.society, this.stealth, this.survival, this.thievery,
            this.money, this.portrait, this.heritageId, this.sizeId, this.alignmentId, this.classId
        ];
    }
};