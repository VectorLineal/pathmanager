<template>
  <a-select v-model:value="value" placeholder="Raza" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { racesStorage } from '../../logic/Storage';

const emit = defineEmits("onSelect");

const value = ref();
const options = racesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>