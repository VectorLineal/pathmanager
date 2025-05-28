<template>
  <a-select v-model:value="value" placeholder="Raza" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { racesStorage } from '../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = racesStorage.dataSelector;

const handleChange = value => {
  const raceData = racesStorage.getEntryById(value);
  emit("onSelect", raceData);
};
</script>