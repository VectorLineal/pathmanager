<template>
  <a-select v-model:value="value" mode="tags" placeholder="Lenguajes" :options="options" show-search :filter-option="filterOption" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { languagesStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const props = defineProps({
    initialValue: Array
});

const value = ref(props.initialValue != null? props.initialValue:[]);
const options = languagesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
const filterOption = (input, option) => {
  return option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0;
};
</script>