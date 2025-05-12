<template>
    <template v-if="isSignificant">
        <b>{{props.name}}</b><Modifier :amount="props.amount"/>{{ ' ' }}
    </template>
</template>
<script setup>
import { computed } from 'vue';
import Modifier from './Modifier.vue';
const props = defineProps({
    name: String,
    amount: Number
});

const isSignificant = computed(() => {
    return props.amount != 0;
});
</script>