<template>
  <a-tag :color="color">{{ props.name }}</a-tag>
</template>
<script setup>
import { computed } from 'vue';
const props = defineProps({
    name: String,
    rarity: Number
});

const color = computed(() => {
    switch(props.rarity){
        case 1:
        default:
            return '#bfafbf';
        case 2:
            return '#1023ff';
        case 3:
            return '#ff00bf';
        case 4:
            return '#ffbf00';
    }
})
</script>