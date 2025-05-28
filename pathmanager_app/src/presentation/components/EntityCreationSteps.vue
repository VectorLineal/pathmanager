<template>
  <div>
    <a-steps :current="current" :items="items"></a-steps>
    <KeepAlive>
      <LevelClassRaceForm ref="lcrRef" v-if="current == 0" @updateData="onClassRaceUpdate" />
    </KeepAlive>
    <div class="steps-content" v-if="current > 0">
      {{ steps[current].content }}
    </div>
    <div class="steps-action">
      <a-button v-if="current > 0" style="margin-left: 8px" @click="prev">Previous</a-button>
      <a-button v-if="current < steps.length - 1" type="primary" @click="next">Next</a-button>
      <a-button v-if="current == steps.length - 1" type="primary"  @click="completeEntity">
        Done
      </a-button>
    </div>
  </div>
</template>
<script setup>
import { ref, reactive, useTemplateRef, toRaw } from 'vue';
import { message } from 'ant-design-vue';
import Entity from '../../data/models/Entity';
import { getAllAlignments } from "../../logic/AlignmentOperations";
import { getAllClasses } from "../../logic/ClassOperations";
import { getAllRaces } from "../../logic/RaceOperations";
import { getAllSizes } from "../../logic/SizeOperations";
import { getAllLanguages } from '../../logic/LanguageOperations';
import { getAllStatusChanges }  from '../../logic/StatusChangeOperations';
import { getAllMovementTypes } from '../../logic/MovementOperations';
import { getAllTraits } from '../../logic/TraitOperations';
import { alignmentsStorage, sizesStorage, racesStorage, classesStorage, languagesStorage, statusChangesStorage, movementsStorage, traitsStorage } from "../../logic/Storage";
import LevelClassRaceForm from './LevelClassRaceForm.vue';

const current = ref(0);
const requestData = reactive(new Entity());

const classRaceRef = useTemplateRef('lcrRef');
const validationState = reactive({
  classRaceValid: false
});

try{
  //se cargan al storage varias listas de valores simples {id, nombre}
  if(alignmentsStorage.isEmpty()) alignmentsStorage.fillData(await getAllAlignments());
  if(sizesStorage.isEmpty()) sizesStorage.fillData(await getAllSizes());
  if(racesStorage.isEmpty()) racesStorage.fillData(await getAllRaces());
  if(classesStorage.isEmpty()) classesStorage.fillData(await getAllClasses());
  if(languagesStorage.isEmpty()) languagesStorage.fillData(await getAllLanguages());
  if(statusChangesStorage.isEmpty()) statusChangesStorage.fillData(await getAllStatusChanges());
  if(movementsStorage.isEmpty()) movementsStorage.fillData(await getAllMovementTypes());
  if(traitsStorage.isEmpty()) traitsStorage.fillData(await getAllTraits());
}catch(error){
  console.error("error on enemies table", error);
}

const validateClassRace = async () => {
  if (classRaceRef.value.validateAndUpdate == null) await classRaceRef.value.$.exposed.validateAndUpdate();
  else await classRaceRef.value.validateAndUpdate();
  return validationState.classRaceValid;
};

const validate = async () => {
  switch (current.value) {
    case 0:
    default:
      return await validateClassRace();
    case 1:
      return true;
    case 2:
      return true;
    case 3:
      return true;
    case 4:
      return true;
    case 5:
      return true;
  }
};

const next = async () => {
  const validator = await validate();
  if (validator){
    current.value++;
    console.log("acumulated data: ", toRaw(requestData));
  }
};
const prev = () => {
  current.value--;
};
const completeEntity = async () => {
  const validator = await validate();

  if (validator) onSubmit();
};

const onSubmit = () => {
  message.success('Personaje CREADO');
};

const onClassRaceUpdate = (data, valid) => {
  validationState.classRaceValid = valid;
  if(valid){
    requestData.setLevel(data.level);
    requestData.name = data.name;
    requestData.description = data.description;
    requestData.classId = data.clase;
    requestData.raceId = data.race;
    requestData.traits = data.traits;
  }
}

const steps = [
  {
    title: 'Raza y Clase',
    content: 'Elegir nombre, Raza junto con clase y nivel'
  },
  {
    title: 'Razgos Físicos',
    content: 'Elegir tamaño, lenguajes, inmunidades, movimientos, sentidos y resistencias'
  },
  {
    title: 'Atributos',
    content: 'Elegir atributos y habilididades base',
  },
  {
    title: 'Defensas',
    content: 'Modificar AC, salud, percepción, fortaleza, reflejos, voluntad',
  },
  {
    title: 'Ataques',
    content: 'Ataques y habilidades especiales',
  },
  {
    title: 'Hechizos',
    content: 'Opcionalmente se pueden añadir hechizos',
  },
];
const items = steps.map(item => ({
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

[data-theme='dark'] .steps-content {
  background-color: #2f2f2f;
  border: 1px dashed #404040;
}
</style>
