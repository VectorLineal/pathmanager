<template>
  <a-select v-model:value="value" placeholder="Categoría" :options="options" @change="handleChange"/>
</template>
<script setup>
import { ref } from 'vue';
import { weaponCategoriesStorage } from '../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = weaponCategoriesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>