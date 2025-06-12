<template>
  <a-select v-model:value="value" placeholder="Tipo de Daño" show-search :filter-option="filterOption" :options="options" @change="handleChange"/>
</template>
<script setup>
import { ref } from 'vue';
import { damageTypesStorage } from '../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = damageTypesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
const filterOption = (input, option) => {
  return option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0;
};
</script>