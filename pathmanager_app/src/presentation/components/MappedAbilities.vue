<template>
    <h5>Habilidades:</h5>
    <p v-for="habilidad in props.abilities">
        <AbilityDetails :ability="habilidad"/>
    </p>
</template>
<script setup>
import AbilityDetails from './AbilityDetails.vue';
const props = defineProps({
    abilities: Array
});
</script>