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
      <a-col :sm="7" :md="6" :lg="6" :xl="6">
        <a-form-item label="Tamaño" name="size">
          <SizeSelector :initialValue="props.intialData.sizeId" @onSelect="selectSize" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Lenguajes" name="languages">
          <LanguagesSelector :initialValue="props.intialData.languages" @onSelect="selectLanguages" />
        </a-form-item>
      </a-col>
      <a-col :sm="8" :md="7" :lg="7" :xl="5">
        <a-form-item label="Inmunidades" name="inmunities">
          <InmunitiesSelector :initialValue="props.intialData.inmunities" @onSelect="selectInmunities" />
        </a-form-item>
      </a-col>
    </a-row>
  </a-form>
</template>
<script setup>
import { reactive, ref, toRaw } from "vue";
import SizeSelector from "./SizeSelector.vue";
import InmunitiesSelector from "./InmunitiesSelector.vue";
import LanguagesSelector from "./LanguagesSelector.vue";

const props = defineProps({
  intialData: Object
});

const emit = defineEmits(["updateData"]);

const formState = reactive({
  size: props.intialData != null? props.intialData.sizeId:0,
  movements: props.intialData != null? props.intialData.movements:[],
  languages: props.intialData != null? props.intialData.languages:[],
  resistances: props.intialData != null? props.intialData.resistances:[],
  inmunities: props.intialData != null? props.intialData.inmunities:[],
  senses: props.intialData != null? props.intialData.senses:[],
});
const formRef = ref();
const labelCol = {
  span: 24,
};
const wrapperCol = {
  span: 24,
};

const rules = {
  size: [
    {
      required: true,
      message: "Seleccione un tamaño",
      trigger: "change",
    },
  ],
  movements: [
    {
      type: 'array',
      required: true,
      message: "Seleccione al menos un movimiento",
      trigger: "change",
    },
  ],
  senses: [
    {
      whitespace: true,
      required: true,
      message: "Seleccione al menos un tipo de sentido",
      trigger: "change",
    },
  ],
};

const selectLanguages = (value) => {
  formState.languages = value;
};
const selectSize = (value) => {
  formState.size = value;
};
const selectInmunities = (value) => {
  formState.inmunities = value;
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