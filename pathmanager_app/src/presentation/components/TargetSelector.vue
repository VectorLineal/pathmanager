<template>
  <a-select v-model:value="value" placeholder="Blancos" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { spellTargetsStorage } from '../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = spellTargetsStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>