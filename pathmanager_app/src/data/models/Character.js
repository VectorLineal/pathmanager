export default class Character{
    constructor(name = '', level = 1, description = '', perception = 0, health = 10, fort = 0, reflex = 0, will = 0, str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0, money = 0, acrobatics = 0, arcana = 0, atletism = 0, crafting = 0, deceiving = 0, diplomacy = 0, intimidation = 0, medicine = 0, nature = 0, ocultism = 0, performance = 0, religion = 0, society = 0, stealth = 0, survival = 0, thievery = 0, classId = null, raceId = null, alignmentId = null, sizeId = null){
        this.name = name;
        this.description = description;
        this.level = level;
        this.xp = 0;
        this.perception = perception;
        this.health = health;
        this.fort = fort;
        this.reflex = reflex;
        this.will = will;
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
        this.spells = [];
        this.inmunities = [];
        this.resistances = [];
        this.senses = [];
        this.languages = [];
        this.movements = [];
    }

    setLevel(level){
        this.level = level;
        this.xp = 0;
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
    getArmor(){
        return this.dex;
    }
    getCreationVector(){
        return [this.name, this.description, this.level, this.xp, this.perception, this.health, this.fort,
            this.reflex, this.will, this.str, this.dex, this.con, this.int, this.wis, this.cha,
            this.acrobatics, this.arcana, this.atletism, this.crafting, this.deceiving, this.diplomacy,
            this.intimidation, this.medicine, this.nature, this.ocultism, this.performance, this.religion,
            this.society, this.stealth, this.survival, this.thievery, this.money, this.sizeId,
            this.alignmentId, this.classId, this.raceId
        ];
    }
};