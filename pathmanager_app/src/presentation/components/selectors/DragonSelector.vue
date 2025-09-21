<template>
  <a-select v-model:value="value" placeholder="Tipo de Dragón" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { dragonsStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = dragonsStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>