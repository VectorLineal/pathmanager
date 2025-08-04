import Character from "./Character";

export default class Entity extends Character{
    constructor(name = '', level = 1, loot = '', description = '', perception = 0, naturalArmor = 0, itemArmor = 0, dodge = 0, health = 10, fort = 0, reflex = 0, will = 0, attackBonus = 0, str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0, money = 0, acrobatics = 0, arcana = 0, atletism = 0, crafting = 0, deceiving = 0, diplomacy = 0, intimidation = 0, lore = 0, medicine = 0, nature = 0, ocultism = 0, performance = 0, religion = 0, society = 0, stealth = 0, survival = 0, thievery = 0, classId = null, raceId = null, alignmentId = null, sizeId = null){
        super(name, level, description, perception, health, fort, reflex, will, str, dex, con, int, wis, cha, money, acrobatics, arcana, atletism, crafting, deceiving, diplomacy, intimidation, medicine, nature, ocultism, performance, religion, society, stealth, survival, thievery, classId, raceId, alignmentId, sizeId);
        this.loot = loot;
        this.xp = this.calculateXp();
        this.naturalArmor = naturalArmor;
        this.itemArmor = itemArmor;
        this.dodge = dodge;
        this.attackBonus = attackBonus;
        this.lore = lore;
        this.attacks = [];
    }

    calculateXp(){
        if (this.level <= 3)  return 200 * (this.level + 1);
        else {
            let experience = 800;
            for(let i = 4; i <= this.level; i++){
                experience = (i % 2 == 0? experience * 1.5: experience + (experience /3));
            }
            return experience;
        }
    }

    setLevel(level){
        this.level = level;
        this.xp = this.calculateXp();
    }
    getFlatFootedArmor(){
        return this.naturalArmor + this.itemArmor;
    }
    getArmor(){
        return this.getFlatFootedArmor() + this.dodge + this.dex;
    }
    getCreationVector(){
        return [this.name, this.description, this.loot, this.level, this.xp, this.perception, this.naturalArmor,
            this.itemArmor, this.dodge, this.health, this.fort, this.reflex, this.will, this.attackBonus,
            this.str, this.dex, this.con, this.int, this.wis, this.cha, this.acrobatics, this.arcana, this.atletism,
            this.crafting, this.deceiving, this.diplomacy, this.intimidation, this.lore, this.medicine, this.nature,
            this.ocultism, this.performance, this.religion, this.society, this.stealth, this.survival, this.thievery,
            this.money, this.raceId, this.sizeId, this.alignmentId, this.classId
        ];
    }
};