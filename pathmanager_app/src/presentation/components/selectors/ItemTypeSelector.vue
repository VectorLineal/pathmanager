<template>
  <a-select v-model:value="value" placeholder="Tipo de Ítem" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { itemTypesStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = itemTypesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>