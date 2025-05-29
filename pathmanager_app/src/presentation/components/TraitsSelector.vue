<template>
  <a-select v-model:value="value" mode="tags" placeholder="Los razgos son opcionales" :options="options" :filter-option="filterOption" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { traitsStorage } from '../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref([]);
const options = traitsStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
const filterOption = (input, option) => {
  return option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0;
};
</script>