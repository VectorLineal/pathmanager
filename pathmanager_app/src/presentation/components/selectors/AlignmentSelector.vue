<template>
  <a-select v-model:value="value" placeholder="Alineación" :options="options" @change="handleChange"
  ></a-select>
</template>
<script setup>
import { ref, computed, watch } from 'vue';
import { alignmentsStorage } from '../../../logic/Storage';

const emit = defineEmits(["onSelect"]);

const props = defineProps({
  constraints: Array
});

const value = ref();
const options = computed(() => {
  const base = alignmentsStorage.dataSelector;
  if(props.constraints == null || props.constraints.length <= 0) return base;
  else{
    const opts = [];
    base.forEach((entry) => {
      if(props.constraints.includes(entry.value)) opts.push(entry);
    });
    return opts;
  }
});

watch(() => props.constraints,
(newValue, oldValue) => {
  if(!newValue.includes(value.value)){
    value.value = null;
    emit("onSelect", null);
  }
});

const handleChange = value => {
  emit("onSelect", value);
};
</script>