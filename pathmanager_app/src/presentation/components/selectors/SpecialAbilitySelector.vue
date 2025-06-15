<template>
  <a-select v-model:value="value" mode="tags" placeholder="Habilidades Especiales" :options="abilities" :filter-option="filterOption" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref, inject } from 'vue';

const emit = defineEmits(["onSelect"]);

const {abilities, loadAbilities} = inject('abilities');

const value = ref([]);

const handleChange = value => {
  emit("onSelect", value);
};
const filterOption = (input, option) => {
  return option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0;
};
</script>