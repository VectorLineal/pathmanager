<template>
  <b>Sentidos: </b>
  <template v-for="sentido in props.senses">
    <UExtraInfo :name="sentido.nombre" :description="sentido.descripcion" />
    <span v-if="sentido.rango != null">{{ " " + sentido.rango }}</span>
  </template>
</template>
<script setup>
import UExtraInfo from './generic/UExtraInfo.vue';

const props = defineProps({
  senses: Array
});
</script>
