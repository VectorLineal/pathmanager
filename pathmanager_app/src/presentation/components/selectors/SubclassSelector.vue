<template>
  <a-select v-model:value="value" :placeholder="'Seleccione ' + props.type" :options="options" @change="handleChange"/>
</template>
<script setup>
import { ref, watch } from "vue";

const props = defineProps({
  data: Array,
  type: String,
  index: Number
});

const emit = defineEmits(["onSelect"]);

const value = ref();
const options = ref([]);

props.data.forEach((element) => {
  options.value.push({
    value: element.id,
    label: element.nombre,
  });
});

watch(
  () => props.data,
  (newValue, oldValue) => {
    options.value = [];
    value.value = null;
    newValue.forEach((element) => {
      options.value.push({
        value: element.id,
        label: element.nombre,
      });
    });
  }
);

const handleChange = (value) => {
  emit("onSelect", value, props.index);
};
</script>
