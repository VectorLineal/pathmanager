<template>
  <a-space
    v-for="(sense, index) in senses"
    :key="sense.sentidoId"
    class="list-field"
    align="baseline"
  >
    <a-select v-model:value="sense.sentidoId" placeholder="Sentidos" show-search :filter-option="filterOption" :options="sensesStorage.dataSelector" @change="triggerUpdate"/>
    <a-input-number v-model:value="sense.rango" :min="0" :max="100" @change="triggerUpdate"/>
    <MinusCircleOutlined @click="removeElement(index)" />
  </a-space>
  <a-button type="dashed" block @click="addElement">
    <PlusOutlined /> Añadir Sentido
  </a-button>
</template>
<script setup>
import { ref } from "vue";
import { MinusCircleOutlined, PlusOutlined } from "@ant-design/icons-vue";
import { sensesStorage } from "../../logic/Storage";

const props = defineProps({
  initialData: Array,
});

const emit = defineEmits(['updatedValues']);

const senses = ref(props.initialData != null ? props.initialData : []);

const triggerUpdate = () => {
  emit('updatedValues', senses.value);
}

const removeElement = (index) => {
  if (index >= 0){
    senses.value.splice(index, 1);
    triggerUpdate();
  }
};
const addElement = () => {
  senses.value.push({
    sentidoId: null,
    rango: 0,
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