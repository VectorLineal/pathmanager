export default class Entity{
    constructor(name = '', level = 1, loot = '', description = '', perception = 0, naturalArmor = 0, itemArmor = 0, dodge = 0, health = 10, fort = 0, reflex = 0, will = 0, attackBonus = 0, str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0, money = 0, acrobatics = 0, arcana = 0, atletism = 0, crafting = 0, deceiving = 0, diplomacy = 0, intimidation = 0, lore = 0, medicine = 0, nature = 0, ocultism = 0, performance = 0, religion = 0, society = 0, stealth = 0, survival = 0, thievery = 0, classId = null, raceId = null, alignmentId = null, sizeId = null){
        this.name = name;
        this.loot = loot;
        this.description = description;
        this.level = level;
        this.xp = this.calculateXp();
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
        this.classId = classId;
        this.raceId = raceId;
        this.sizeId = sizeId;
        this.alignmentId = alignmentId;
        this.traits = [];
        this.abilities = [];
        this.inmunities = [];
        this.resistances = [];
        this.senses = [];
        this.languages = [];
        this.movements = [];
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
        this.calculateXp();
    }

    setInmunities(inmunities){
        inmunities.forEach((item) => {
            this.inmunities.push(item.estadoId);
        });
    }

    setAbilities(abilities){
        abilities.forEach((item) => {
            this.abilities.push(item.habilidadId);
        });
    }

    setLanguages(languages){
        this.languages = [];
        languages.forEach((item) => {
            this.languages.push(item.lenguajeId);
        });
    }

    getFlatFootedArmor(){
        return this.naturalArmor + this.itemArmor;
    }
    getArmor(){
        return this.getFlatFootedArmor() + this.dodge + this.dex;
    }
};