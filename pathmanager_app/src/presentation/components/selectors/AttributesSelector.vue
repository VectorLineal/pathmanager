<template>
  <a-space
    v-for="(attribute, index) in attributes"
    :key="attribute.id"
    class="list-field"
    align="baseline"
  >
    <a-select v-model:value="attribute.id" placeholder="Razgo" show-search :filter-option="filterOption" :options="attributesStorage.dataSelector" @select="triggerUpdate"/>
    <a-input-number v-model:value="attribute.cantidad" :min="-50" :max="50" @change="triggerUpdate"/>
    <MinusCircleOutlined @click="removeElement(index)" />
  </a-space>
  <a-button type="dashed" block @click="addElement">
    <PlusOutlined /> Añadir Atributo
  </a-button>
</template>
<script setup>
import { ref } from "vue";
import { MinusCircleOutlined, PlusOutlined } from "@ant-design/icons-vue";
import { attributesStorage } from "../../../logic/Storage";

const emit = defineEmits(['updatedValues']);

const attributes = ref([]);

const triggerUpdate = () => {
  emit('updatedValues', attributes.value);
}

const removeElement = (index) => {
  if (index >= 0){
    attributes.value.splice(index, 1);
    triggerUpdate();
  }
};
const addElement = () => {
  attributes.value.push({
    id: null,
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