<template>
  <a-form
    layout="vertical"
    :model="formState"
    ref="formRef"
    :rules="rules"
    :label-col="labelCol"
    :wrapper-col="wrapperCol"
  >
    <a-form-item label="Nombre" name="name">
      <a-input v-model:value="formState.name" />
    </a-form-item>
    <a-form-item label="Nivel" name="level">
      <a-input-number v-model:value="formState.level" :min="0" :max="23" />
    </a-form-item>
    <a-form-item label="Raza" name="race">
      <RaceSelector @onSelect="selectClass"/>
    </a-form-item>
    <a-form-item label="Clase" name="clase">
      <ClassSelector @onSelect="selectRace"/>
    </a-form-item>
    <a-form-item label="Razgos" name="traits">
      <TraitsSelector @onSelect="selectTraits"/>
    </a-form-item>
  </a-form>
</template>
<script setup>
import { reactive, ref } from "vue";
import ClassSelector from "./ClassSelector.vue";
import RaceSelector from "./RaceSelector.vue";
import TraitsSelector from "./TraitsSelector.vue";

const formState = reactive({
  level: 0,
  name: "",
  clase: null,
  race: null,
  traits: [],
});
const formRef = ref();
const labelCol = {
  span: 5,
};
const wrapperCol = {
  span: 13,
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
    } else if (value > 23) {
      return Promise.reject("El máximo es 23");
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
      message: "Seleccione",
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
  console.log(`selected ${value}`);
  formState.clase = value;
};
const selectRace = (value) => {
  console.log(`selected ${value}`);
  formState.race = value;
};
const selectTraits = (value) => {
  console.log(`selected ${value}`);
  formState.traits = value;
};

const onSubmit = () => {
  formRef.value
    .validate()
    .then(() => {
      console.log("values", formState, toRaw(formState));
    })
    .catch((error) => {
      console.log("error", error);
    });
};
</script>
