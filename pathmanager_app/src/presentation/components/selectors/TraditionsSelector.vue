<template>
  <a-select v-model:value="value" mode="tags" placeholder="Tradiciones" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { spellTraditionsStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref([]);
const options = spellTraditionsStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>