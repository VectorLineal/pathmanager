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
      <a-col :sm="4" :md="3" :lg="3" :xl="3">
        <a-form-item label="Nivel" name="level">
          <a-input-number v-model:value="formState.level" :min="0" :max="25" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="6">
        <a-form-item label="Raza" name="race">
          <RaceSelector @onSelect="selectRace" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Clase" name="clase">
          <ClassSelector @onSelect="selectClass" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Alineación" name="alineacion">
          <AlignmentSelector @onSelect="selectAlignment" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="3">
        <a-form-item label="Dinero" name="dinero">
          <a-input-number v-model:value="formState.dinero" :min="0" />
        </a-form-item>
      </a-col>
      <a-col :sm="8" :md="7" :lg="7" :xl="5">
        <a-form-item label="Razgos" name="traits">
          <TraitsSelector @onSelect="selectTraits" />
        </a-form-item>
      </a-col>
    </a-row>
    <a-row justify="center">
      <a-col :xs="25" :sm="24" :lg="12">
        <a-form-item label="Descripción" name="description">
          <a-textarea v-model:value="formState.description" />
        </a-form-item>
      </a-col>
      <a-col :xs="25" :sm="24" :lg="12">
        <a-form-item label="Tesoro" name="tesoro">
          <a-textarea v-model:value="formState.tesoro" />
        </a-form-item>
      </a-col>
    </a-row>
  </a-form>
</template>
<script setup>
import { reactive, ref, toRaw } from "vue";
import ClassSelector from "./ClassSelector.vue";
import RaceSelector from "./RaceSelector.vue";
import TraitsSelector from "./TraitsSelector.vue";
import AlignmentSelector from "./AlignmentSelector.vue";

const emit = defineEmits(["updateData"]);

const formState = reactive({
  level: 0,
  name: "",
  description: "",
  clase: null,
  alineacion: null,
  tradicionHechizo: null,
  tesoro: '',
  dinero: 0,
  race: null,
  traits: [],
});
const formRef = ref();
const labelCol = {
  span: 24,
};
const wrapperCol = {
  span: 24,
};

const checkLevel = async (_rule, value) => {
  if (value == null) {
    return Promise.reject("Escriba un nivel");
  }
  if (!Number.isInteger(value)) {
    return Promise.reject("EL nivel debe ser un número entero");
  } else {
    if (value < 0) {
      return Promise.reject("El nivel mínimo es 0");
    } else if (value > 25) {
      return Promise.reject("El máximo es 25");
    } else {
      return Promise.resolve();
    }
  }
};

const rules = {
  level: [
    {
      validator: checkLevel,
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
  race: [
    {
      required: true,
      message: "Seleccione una raza",
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

const selectClass = (value) => {
  formState.clase = value.id;
  formState.tradicionHechizo = value.tradicionId;
};
const selectAlignment = (value) => {
  formState.alineacion = value;
};
const selectRace = (value) => {
  formState.race = value.id;
};
const selectTraits = (value) => {
  formState.traits = value;
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
