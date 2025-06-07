<template>
  <a-select v-model:value="value" placeholder="Grupos de Arma" :options="options" @change="handleChange"/>
</template>
<script setup>
import { ref } from 'vue';
import { weaponGroupsStorage } from '../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = weaponGroupsStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>