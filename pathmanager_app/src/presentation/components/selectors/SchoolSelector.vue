<template>
  <a-select v-model:value="value" placeholder="Escuela" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { spellSchoolsStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = spellSchoolsStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>