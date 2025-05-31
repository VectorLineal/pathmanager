<template>
  <a-space
    v-for="(spell, index) in spells"
    :key="spell.hechizoId"
    class="list-field"
    align="baseline"
  >
    <a-select v-model:value="spell.hechizoId" placeholder="Hechizos" :options="availableSpells" :filter-option="filterOption" @change="triggerUpdate"/>
    <a-input-number v-model:value="spell.cantidad" :min="1" :max="10" @change="triggerUpdate"/>
    <a-input-number v-model:value="spell.aumento" :min="2" :max="10" @change="triggerUpdate"/>
    <MinusCircleOutlined @click="removeElement(index)" />
  </a-space>
  <a-button type="dashed" block @click="addElement">
    <PlusOutlined /> Añadir Hechizo
  </a-button>
</template>
<script setup>
import { ref, inject } from "vue";
import { MinusCircleOutlined, PlusOutlined } from "@ant-design/icons-vue";

const emit = defineEmits(['updatedValues']);

const {availableSpells, loadSpells} = inject('spells');

const spells = ref([]);

const filterOption = (input, option) => {
  return option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0;
};

const triggerUpdate = () => {
  emit('updatedValues', spells.value);
}

const removeElement = (index) => {
  if (index >= 0){
    spells.value.splice(index, 1);
    triggerUpdate();
  }
};
const addElement = () => {
  spells.value.push({
    hechizoId: null,
    cantidad: 0,
    aumento: null
  });
  triggerUpdate();
};
</script>
<style scoped>
.list-field {
  display: flex;
  margin-bottom: 8px;
}
</style>