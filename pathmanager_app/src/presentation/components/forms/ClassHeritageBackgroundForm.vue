<template>
  <a-form
    layout="vertical"
    :model="formState"
    ref="formRef"
    :rules="rules"
    :label-col="labelCol"
    :wrapper-col="wrapperCol"
  >
    <a-row justify="space-around">
      <a-col :sm="8" :md="7" :lg="6" :xl="4">
        <a-form-item label="Nombre" name="name">
          <a-input v-model:value="formState.name" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="6">
        <a-form-item label="Transfondo" name="transfondo">
          <a-select v-model:value="formState.transfondo" placeholder="Transfondo" :options="backgroundOptions"/>
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="6">
        <a-form-item label="Raza" name="raza">
          <RaceSelector @onSelect="selectRace" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="6" v-if="formState.raza != null">
        <a-form-item label="Linaje" name="herencia">
          <a-select v-model:value="formState.herencia" placeholder="Linaje" :options="heritageOptions"/>
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Clase" name="clase">
          <ClassSelector @onSelect="selectClass" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4" v-for="(value, index) in selectedSubclasses">
        <a-form-item :label="value.name" :name="'subclase' + (index == 0 ? '' : '2')">
          <SubclassSelector
            :index="index"
            :type="value.name"
            :data="value.data"
            @onSelect="selectSubClass"
          />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="6">
        <a-form-item label="Deidad" name="deidad">
          <a-select v-model:value="formState.deidad" placeholder="Deidad" :options="deityOptions" @change="onDeitySelect"/>
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Alineación" name="alineacion">
          <AlignmentSelector :constraints="contraintAlignment" @onSelect="selectAlignment" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="6">
        <a-form-item label="Fuente" name="fuente">
          <a-select v-model:value="formState.fuente" placeholder="Fuente" :options="fontOptions"/>
        </a-form-item>
      </a-col>
    </a-row>
    <a-row justify="center">
      <a-col :xs="25" :sm="24" :lg="12">
        <a-form-item label="Descripción" name="description">
          <a-textarea v-model:value="formState.description" />
        </a-form-item>
      </a-col>
    </a-row>
  </a-form>
</template>
<script setup>
import { reactive, ref, toRaw, computed } from "vue";
import ClassSelector from "../selectors/ClassSelector.vue";
import RaceSelector from "../selectors/RaceSelector.vue";
import AlignmentSelector from "../selectors/AlignmentSelector.vue";
import SubclassSelector from "../selectors/SubclassSelector.vue";
import { getSubclassesByClass, getSubclassDataByIdLevel, getSanctificationBySubclass } from "../../../logic/SubclassOperations";
import { getHeritageOptionsByRace } from "../../../logic/HeritageOperations";
import { getBackgroundOptions } from "../../../logic/BackgroundOperations";
import { getDeityOptions, getDeityById } from "../../../logic/DeityOperations";
import { getAdyacentAlignments } from "../../../logic/AlignmentOperations";
import { hasValueOption } from "../../../logic/utilities/StructureUtils";

const emit = defineEmits(["updateData"]);

const formState = reactive({
  name: "",
  description: "",
  clase: null,
  subclase: null,
  subclase2: null,
  alineacion: null,
  tradicionHechizo: null,
  raza: null,
  herencia: null,
  transfondo: null,
  deidad: null,
  fuente: null
});
const formRef = ref();
const labelCol = { span: 24 };
const wrapperCol = { span: 24 };

const deitiesContraint = ref(0);
const selectedSubclasses = ref([]);
const heritageOptions = ref([]);
const backgroundOptions = ref([]);
const deityOptions = ref([]);
const contraintAlignment = ref([]);

const subclassData = ref();
const subclassData2 = ref();
const deityData = ref();

backgroundOptions.value = await getBackgroundOptions();
deityOptions.value = await getDeityOptions();

const fontOptions = computed(() => {
  const holy = {value: 1, label: "vital"};
  const unholy = {value: 2, label: "dañina"};
  return deitiesContraint.value == -1? [unholy]: (deitiesContraint.value == 1? [holy]:[holy, unholy]);
});

const hasDeityRestrictions = computed(() => {
  return formState.clase === 2 || formState.clase === 8;
});

const rules = computed(() => {
  return {
    deidad: [
      {
        required: hasDeityRestrictions.value,
        message: "Los clérigos y campeones deben elegir deidad",
        trigger: "change",
      },
    ],
    clase: [
      {
        required: true,
        message: "Seleccione una clase",
        trigger: "change",
      },
    ],
    herencia: [
      {
        required: true,
        message: "Seleccione una herencia",
        trigger: "change",
      },
    ],
    raza: [
      {
        required: true,
        message: "Seleccione una raza",
        trigger: "change",
      },
    ],
    transfondo: [
      {
        required: true,
        message: "Seleccione un transfondo",
        trigger: "change",
      },
    ],
    alineacion: [
      {
        required: true,
        message: "Seleccione una alineación",
        trigger: "change",
      },
    ],
    name: [
      {
        whitespace: true,
        required: true,
        message: "Escriba un nombre",
        trigger: "change",
      },
    ],
  };
});

const selectClass = async (value) => {
  formState.clase = value.id;
  formState.tradicionHechizo = value.tradicionId;
  selectedSubclasses.value = await getSubclassesByClass(value.id);
};
const selectSubClass = async (value, index) => {
  const subData = await getSubclassDataByIdLevel(value, 1);
  //las santificaciones d epaladin limitan que dioses pueden ser seleccionados
  const deityConstarint = getSanctificationBySubclass(value);
  if(deityConstarint != deitiesContraint.value){
    deityOptions.value = await getDeityOptions(deityConstarint);
    //se resetea el valor de deidad si las nuevas deidades no contienen la seleccionada previamente
    if(!hasValueOption(formState.deidad, deityOptions.value)) formState.deidad = null;
    deitiesContraint.value = deityConstarint;
  }
  //los hechiceros tienen diferentes escuelas de hechizo dependiendo de su línea de sangre
  if(subData.spellTradition > 0) formState.tradicionHechizo = subData.spellTradition;

  if (index == 0){
    formState.subclase = value;
    subclassData.value = subData;
  }
  else{
    formState.subclase2 = value;
    subclassData2.value = subData;
  }
};
const selectAlignment = (value) => {
  formState.alineacion = value;
};
const selectRace = async (value) => {
  formState.raza = value.id;
  heritageOptions.value = await getHeritageOptionsByRace(formState.raza);
};
const onDeitySelect = async (value) => {
  deityData.value = await getDeityById(value);
  if(hasDeityRestrictions.value) contraintAlignment.value = getAdyacentAlignments(deityData.value.alineacionId);
};

const validateAndUpdate = async () => {
  try {
    await formRef.value.validate();
    const formData = toRaw(formState);
    emit("updateData", formData, true);
  } catch (error) {
    emit("updateData", {}, false);
    return;
  }
};
defineExpose({ validateAndUpdate });
</script>
