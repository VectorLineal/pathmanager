<template>
  {{ modifier }}
</template>
<script setup>
import { computed } from 'vue';
const props = defineProps({
    amount: Number
});

const modifier = computed(() => {
    return (props.amount > 0? '+':'') + props.amount;
});
</script>