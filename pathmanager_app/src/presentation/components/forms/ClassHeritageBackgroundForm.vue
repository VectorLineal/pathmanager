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
        <a-form-item label="Raza" name="raza">
          <RaceSelector @onSelect="selectRace" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Alineación" name="alineacion">
          <AlignmentSelector @onSelect="selectAlignment" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Clase" name="clase">
          <ClassSelector @onSelect="selectClass" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4" v-for="(value, index) in selectedSubclasses">
        <a-form-item :label="value.name" :name="'subclase' + (index == 0? '':'2')">
          <SubclassSelector :index="index" :type="value.name" :data="value.data" @onSelect="selectSubClass" />
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
import { reactive, ref, toRaw } from "vue";
import ClassSelector from "../selectors/ClassSelector.vue";
import RaceSelector from "../selectors/RaceSelector.vue";
import AlignmentSelector from "../selectors/AlignmentSelector.vue";
import SubclassSelector from "../selectors/SubclassSelector.vue";
import { getSubclassesByClass } from "../../../logic/SubclassOperations";
import SubclassSelector from "../selectors/SubclassSelector.vue";

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
  transfondo: null
});
const formRef = ref();
const labelCol = {
  span: 24,
};
const wrapperCol = {
  span: 24,
};
const selectedSubclasses = ref([]);

const rules = {
  deidad: [
    {
      required: true,
      message: "Seleccione una deidad",
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

const selectClass = async (value) => {
  formState.clase = value.id;
  formState.tradicionHechizo = value.tradicionId;
  selectedSubclasses.value = await getSubclassesByClass(value);
};
const selectSubClass = (value, index) => {
  if(index == 0) formState.subclase = value;
  else formState.subclase2 = value;
};
const selectAlignment = (value) => {
  formState.alineacion = value;
};
const selectRace = (value) => {
  formState.raza = value.id;
};

const validateAndUpdate = async () => {
  try {
    await formRef.value.validate();
    emit("updateData", toRaw(formState), true);
  } catch (error) {
    emit("updateData", {}, false);
    return;
  }
};
defineExpose({ validateAndUpdate });
</script>