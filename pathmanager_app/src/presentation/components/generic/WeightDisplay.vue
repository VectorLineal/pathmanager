<template>
    <span>{{ weightText }}</span>
</template>
<script setup>
import { computed } from 'vue';

const props = defineProps({
    weight: Number
});

const weightText = computed(() => {
    if(props.weight == 0.1) return 'L';
    else if(props.weight < 0.1 && props.weight > 0) return Math.round(0.1 / props.weight).toString() + 'x L';
    else if(props.weight > 0.1 && props.weight < 1) return Math.floor(1 / props.weight).toString() + 'L';
    else return Math.floor(props.weight).toString();
});
</script>