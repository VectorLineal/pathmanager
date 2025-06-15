<template>
  <a-space
    v-for="(resistance, index) in resistances"
    :key="resistance.danoId"
    class="list-field"
    align="baseline"
  >
    <a-select v-model:value="resistance.danoId" placeholder="Resistencia" show-search :filter-option="filterOption" :options="damageTypesStorage.dataSelector" @change="triggerUpdate"/>
    <a-input-number v-model:value="resistance.cantidad" :min="-50" :max="50" @change="triggerUpdate"/>
    <MinusCircleOutlined @click="removeElement(index)" />
  </a-space>
  <a-button type="dashed" block @click="addElement">
    <PlusOutlined /> Añadir Resistencia
  </a-button>
</template>
<script setup>
import { ref } from "vue";
import { MinusCircleOutlined, PlusOutlined } from "@ant-design/icons-vue";
import { damageTypesStorage } from "../../../logic/Storage";

const props = defineProps({
  initialData: Array,
});

const emit = defineEmits(['updatedValues']);

const resistances = ref(props.initialData != null ? props.initialData : []);

const triggerUpdate = () => {
  emit('updatedValues', resistances.value);
}

const removeElement = (index) => {
  if (index >= 0){
    resistances.value.splice(index, 1);
    triggerUpdate();
  }
};
const addElement = () => {
  resistances.value.push({
    danoId: null,
    cantidad: 0,
  });
  triggerUpdate();
};
const filterOption = (input, option) => {
  return option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0;
};
</script>
<style scoped>
.list-field {
  display: flex;
  margin-bottom: 8px;
}
</style>
