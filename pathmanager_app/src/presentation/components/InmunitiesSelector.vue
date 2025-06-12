<template>
  <a-select v-model:value="value" mode="tags" placeholder="Cambios de estado" :options="options" show-search :filter-option="filterOption" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { statusChangesStorage } from '../../logic/Storage';

const props = defineProps({
    initialValue: Array
});

const emit = defineEmits(["onSelect"]);

const value = ref(props.initialValue != null? props.initialValue:[]);
const options = statusChangesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
const filterOption = (input, option) => {
  return option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0;
};
</script>