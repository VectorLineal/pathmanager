<template>
  <a-select v-model:value="value" placeholder="Tipo de Daño" :options="options" @change="handleChange"/>
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
</script>