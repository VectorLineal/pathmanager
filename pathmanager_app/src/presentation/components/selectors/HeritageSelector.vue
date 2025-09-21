<template>
  <a-select v-model:value="value" placeholder="Linaje" :options="props.data" @change="handleChange" />
</template>
<script setup>
import { ref } from 'vue';

const props = defineProps({
    data: Array
});

const emit = defineEmits(["onSelect"]);

const value = ref();

const handleChange = value => {
  emit("onSelect", value);
};
</script>