<template>
  <a-select v-model:value="value" placeholder="Clase principal" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { classesStorage } from '../../logic/Storage';

const emit = defineEmits("onSelect");

const value = ref();
const options = classesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>