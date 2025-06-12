<template>
  <div>
    <a-steps :current="current" :items="items"></a-steps>
    <KeepAlive>
      <LevelClassRaceForm
        ref="lcrRef"
        v-if="current == 0"
        @updateData="onClassRaceUpdate"
      />
    </KeepAlive>
    <KeepAlive>
      <PhysicalTraitsForm
        ref="ptRef"
        v-if="current == 1"
        :intialData="requestData"
        @updateData="onPhysicalTraitsUpdate"
      />
    </KeepAlive>
    <KeepAlive>
      <AtributesDeffensesForm
        ref="atRef"
        v-if="current == 2"
        :intialData="requestData"
        @updateData="onAtributessUpdate"
      />
    </KeepAlive>
    <KeepAlive>
      <AttacksSpellsForm
        ref="saRef"
        v-if="current == 3"
        @updateData="onAttackSpellsUpdate"
      />
    </KeepAlive>
    <div class="steps-action">
      <a-button v-if="current > 0" style="margin-left: 8px" @click="prev"
        >Anterior</a-button
      >
      <a-button
        v-if="current <= steps.length - 1"
        type="primary"
        @click="next"
        >{{ nextText }}</a-button
      >
    </div>
  </div>
</template>
<script setup>
import { ref, provide, reactive, useTemplateRef, toRaw, computed } from "vue";
import { message } from "ant-design-vue";
import { useRouter } from "vue-router";
import Entity from "../../data/models/Entity";
import { getAllAlignments } from "../../logic/AlignmentOperations";
import { getAllClasses } from "../../logic/ClassOperations";
import { getAllRaces, getRaceById } from "../../logic/RaceOperations";
import { getAllSizes } from "../../logic/SizeOperations";
import { getAllLanguages } from "../../logic/LanguageOperations";
import { getAllStatusChanges } from "../../logic/StatusChangeOperations";
import { getAllMovementTypes } from "../../logic/MovementOperations";
import { getAllTraits } from "../../logic/TraitOperations";
import { getAllDamageTypes } from "../../logic/DamageTypeOperations";
import { getAllSenses } from "../../logic/SenseOperations";
import { getAllWeapons } from "../../logic/WeaponOperations";
import { getSpellsByTraditionCasterLevel, getFocusSpellsByClassLevel } from "../../logic/SpellOperations";
import { getAllAbilities } from "../../logic/AbilityOperations";
import { createEntity } from "../../logic/EntityOperations";
import {
  alignmentsStorage,
  sizesStorage,
  racesStorage,
  classesStorage,
  languagesStorage,
  statusChangesStorage,
  movementsStorage,
  traitsStorage,
  damageTypesStorage,
  sensesStorage
} from "../../logic/Storage";
import LevelClassRaceForm from "./LevelClassRaceForm.vue";
import PhysicalTraitsForm from "./PhysicalTraitsForm.vue";
import AtributesDeffensesForm from "./AtributesDeffensesForm.vue";
import AttacksSpellsForm from "./AttacksSpellsForm.vue";

const router = useRouter();

const current = ref(0);
const requestData = reactive(new Entity());
const spellTradition = ref();
const availableSpells = ref([]);
const abilities = ref([]);
const weapons = ref([]);


const classRaceRef = useTemplateRef("lcrRef");
const physicalTraitsRef = useTemplateRef("ptRef");
const atributesRef = useTemplateRef("atRef");
const attackSpellsRef = useTemplateRef("saRef");
const nextText = computed(() => {
  return current.value == steps.length - 1 ? "Crear" : "Siguiente";
});

try {
  //se cargan al storage varias listas de valores simples {id, nombre}
  if (alignmentsStorage.isEmpty()) alignmentsStorage.fillData(await getAllAlignments());
  if (sizesStorage.isEmpty()) sizesStorage.fillData(await getAllSizes());
  if (racesStorage.isEmpty()) racesStorage.fillData(await getAllRaces());
  if (classesStorage.isEmpty()) classesStorage.fillData(await getAllClasses());
  if (languagesStorage.isEmpty())  languagesStorage.fillData(await getAllLanguages());
  if (statusChangesStorage.isEmpty()) statusChangesStorage.fillData(await getAllStatusChanges());
  if (movementsStorage.isEmpty()) movementsStorage.fillData(await getAllMovementTypes());
  if (traitsStorage.isEmpty()) traitsStorage.fillData(await getAllTraits());
  if (damageTypesStorage.isEmpty()) damageTypesStorage.fillData(await getAllDamageTypes());
  if (sensesStorage.isEmpty()) sensesStorage.fillData(await getAllSenses());
  //se cargan todas las habilidades especiales
  const abilitiesData = await getAllAbilities();
  abilitiesData.forEach(element => {
    abilities.value.push({label: element.nombre, value: element.id});
  });
  //se cargan todas las armas
  const weaponsData = await getAllWeapons();
  weaponsData.forEach(element => {
    weapons.value.push({label: element.nombre, value: element.id});
  });
} catch (error) {
  console.error("error on enemies table", error);
}

const loadAbilities = async () => {
  try{
    const abilitiesData = await getAllAbilities();
    abilities.value = [];
    abilitiesData.forEach(element => {
      abilities.value.push({label: element.nombre, value: element.id});
    });
  }catch(error){
    console.error("error on load special abilites", error);
  }
};

const loadWeapons = async () => {
  try{
    const weaponsData = await getAllWeapons();
    weapons.value = [];
    weaponsData.forEach(element => {
      weapons.value.push({label: element.nombre, value: element.id});
    });
  }catch(error){
    console.error("error on load weapons", error);
  }
};

const addSpell = (head, option) => {
  let curIndex = -1;
      for(let i = 0; i < availableSpells.value.length; i++){
        if(availableSpells.value[i].label == head){
          curIndex = i;
          break;
        }
      }
      if(curIndex == -1) availableSpells.value.push({label: head, options: [option]});
      else availableSpells.value[curIndex].options.push(option);
}

const loadSpells = async () => {
  try{
    let spellsData = [];
    if(spellTradition.value != null) spellsData = await getSpellsByTraditionCasterLevel(spellTradition.value, requestData.level);
    const focusSpellData = await getFocusSpellsByClassLevel(requestData.classId, requestData.level);
    availableSpells.value = []; 
    spellsData.forEach(element => {
      const head = element.nivel == 0? 'Trucos':'Nivel ' + element.nivel;
      const option = {label: element.nombre, value: element.id};
      addSpell(head, option);
    });
    focusSpellData.forEach(element => {
      const head = 'Foco ' + element.nivel;
      const option = {label: element.nombre, value: element.id};
      addSpell(head, option);
    });
    console.log("loaded SPELLS:", availableSpells.value);
  }catch(error){
    console.error("error on load available spells", error);
  }
};

provide('weapons', {weapons, loadWeapons});
provide('abilities', {abilities, loadAbilities});
provide('spells', {availableSpells, loadSpells});

const validateClassRace = async () => {
  if (classRaceRef.value.validateAndUpdate == null) await classRaceRef.value.$.exposed.validateAndUpdate();
  else await classRaceRef.value.validateAndUpdate();
};
const validatePhysicalTraits = async () => {
  if (physicalTraitsRef.value.validateAndUpdate == null) await physicalTraitsRef.value.$.exposed.validateAndUpdate();
  else await physicalTraitsRef.value.validateAndUpdate();
};
const validateAtributes = async () => {
  if (atributesRef.value.validateAndUpdate == null) await atributesRef.value.$.exposed.validateAndUpdate();
  else await atributesRef.value.validateAndUpdate();
};
const validateAtttackSpells = async () => {
  if (attackSpellsRef.value.validateAndUpdate == null) await attackSpellsRef.value.$.exposed.validateAndUpdate();
  else await attackSpellsRef.value.validateAndUpdate();
};

const validate = async () => {
  switch (current.value) {
    case 0:
    default:
      await validateClassRace();
      return;
    case 1:
      await validatePhysicalTraits();
      return;
    case 2:
      await validateAtributes();
      return;
    case 3:
      await validateAtttackSpells();
      return;
  }
};

const next = async () => {
  await validate();
};
const prev = () => {
  current.value--;
};

const onSubmit = async () => {
  const created = await createEntity(toRaw(requestData));
  if(created){
    message.success(requestData.name + " nivel " + requestData.level + " CREADO");
    router.push('/');
  }
  else message.error("Fallo al crear personaje");
};

const onClassRaceUpdate = async (data, valid) => {
  if (valid) {
    requestData.setLevel(data.level);
    requestData.name = data.name;
    requestData.description = data.description;
    requestData.classId = data.clase;
    requestData.raceId = data.race;
    requestData.traits = data.traits;
    requestData.loot = data.tesoro;
    requestData.money = data.dinero;
    requestData.alignmentId = data.alineacion
    spellTradition.value = data.tradicionHechizo;
    await loadSpells();
    console.log("can cast spells:", availableSpells.value);
    const raceData = await getRaceById(requestData.raceId);
    requestData.sizeId = raceData.tamanoId;
    requestData.health = raceData.salud;
    requestData.str = raceData.fuerza;
    requestData.dex = raceData.destreza;
    requestData.con = raceData.constitucion;
    requestData.int = raceData.inteligencia;
    requestData.wis = raceData.sabiduria;
    requestData.cha = raceData.carisma;
    requestData.resistances = raceData.resistencias;
    requestData.senses = raceData.sentidos;
    requestData.movements = raceData.velocidades;
    requestData.setAbilities(raceData.habilidades);
    requestData.setInmunities(raceData.inmunidades);
    requestData.setLanguages(raceData.lenguages);
    //console.log("acumulated data: ", toRaw(requestData));
    current.value++;
  }
};

const onPhysicalTraitsUpdate = (data, valid) => {
  if (valid) {
    requestData.sizeId = data.size;
    requestData.resistances = data.resistances;
    requestData.senses = data.senses;
    requestData.movements = data.movements;
    requestData.inmunities = data.inmunities;
    requestData.languages = data.languages;
    //console.log("acumulated data: ", toRaw(requestData));
    current.value++;
  }
};

const onAtributessUpdate = (data, valid) => {
  if (valid) {
    requestData.str = data.str;
    requestData.dex = data.dex;
    requestData.con = data.con;
    requestData.int = data.int;
    requestData.wis = data.wis;
    requestData.cha = data.cha;
    requestData.acrobatics = data.acrobatics;
    requestData.arcana = data.arcana;
    requestData.atletism = data.atletism;
    requestData.crafting = data.crafting;
    requestData.deceiving = data.deceiving;
    requestData.diplomacy = data.diplomacy;
    requestData.intimidation = data.intimidation;
    requestData.lore = data.lore;
    requestData.medicine = data.medicine;
    requestData.nature = data.nature;
    requestData.ocultism = data.ocultism;
    requestData.performance = data.performance;
    requestData.religion = data.religion;
    requestData.society = data.society;
    requestData.stealth = data.stealth;
    requestData.survival = data.survival;
    requestData.thievery = data.thievery;
    requestData.naturalArmor = data.naturalArmor;
    requestData.itemArmor = data.itemArmor;
    requestData.dodge = data.dodge;
    requestData.health = data.health;
    requestData.perception = data.perception;
    requestData.attackBonus = data.attackBonus;
    requestData.fort = data.fort;
    requestData.reflex = data.reflex;
    requestData.will = data.will;
    //console.log("acumulated data: ", toRaw(requestData));
    current.value++;
  }
};

const onAttackSpellsUpdate = async (data, valid) => {
  if (valid) {
    requestData.abilities = data.abilities;
    requestData.attacks = data.attacks;
    requestData.spells = data.spells;
    console.log("request data: ", toRaw(requestData));
    await onSubmit();
  }
};

const steps = [
  {
    title: "Raza y Clase",
    content: "Elegir nombre, Raza junto con clase y nivel",
  },
  {
    title: "Razgos Físicos",
    content:
      "Elegir tamaño, lenguajes, inmunidades, movimientos, sentidos y resistencias",
  },
  {
    title: "Atributos y Defensas",
    content:
      "Elegir atributos y habilididades base, Modificar AC, salud, ataqueBase, percepción, fortaleza, reflejos, voluntad",
  },
  {
    title: "Ataques, Habilidades y Hechizos",
    content: "Ataques, habilidades especiales y opcionalmente hechizos",
  },
];
const items = steps.map((item) => ({
  key: item.title,
  title: item.title,
}));
</script>
<style scoped>
.steps-content {
  margin-top: 16px;
  border: 1px dashed #e9e9e9;
  border-radius: 6px;
  background-color: #fafafa;
  min-height: 200px;
  text-align: center;
  padding-top: 80px;
}

.steps-action {
  margin-top: 24px;
}

[data-theme="dark"] .steps-content {
  background-color: #2f2f2f;
  border: 1px dashed #404040;
}
</style>
