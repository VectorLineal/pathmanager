<template>
  <a-select v-model:value="value" placeholder="Alineación" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { alignmentsStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = alignmentsStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>