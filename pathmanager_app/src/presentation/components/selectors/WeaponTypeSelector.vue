<template>
  <a-select v-model:value="value" placeholder="Tipo de Arma" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { weaponTypesStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = weaponTypesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>