<template>
<TraitTag :id="props.id"
    :name="props.monto != null? props.nombre.replace(' x', ' '+ props.monto):props.nombre"
    :description="props.monto != null? props.descripcion.replace('x', props.monto):props.descripcion"
/>
</template>
<script setup>
import TraitTag from './TraitTag.vue';
const props = defineProps({
    id: Number,
    monto: Number,
    nombre: String,
    descripcion: String
})
</script>