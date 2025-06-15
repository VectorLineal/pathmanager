<template>
  <a-select v-model:value="value" placeholder="Tamaño" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref } from 'vue';
import { sizesStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const props = defineProps({
    initialValue: Number
});
console.log("inital size:", props.initialValue);
const value = ref(props.initialValue != null? props.initialValue:2);
const options = sizesStorage.dataSelector;

const handleChange = value => {
  emit("onSelect", value);
};
</script>