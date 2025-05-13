<template>
    <p><b>debilidades: </b><MovInfo v-for="debilidad in debilidades" :name="debilidad.nombre" :amount="debilidad.cantidad"/></p>
    <p><b>resistencias: </b><MovInfo v-for="resistancia in resistencias" :name="resistancia.nombre" :amount="resistancia.cantidad"/></p>
</template>
<script setup>
import { ref } from 'vue';
import MovInfo from './generic/MovInfo.vue';
const props = defineProps({
    resistances: Array
});
const debilidades = ref([]);
const resistencias = ref([]);
props.resistances.forEach((resistance) => {
    if(resistance.cantidad < 0) debilidades.value.push(resistance);
    else resistencias.value.push(resistance);
});
</script>