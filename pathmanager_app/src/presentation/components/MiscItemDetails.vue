<template>
  <TraitTag
    v-for="razgo in miscItem.razgos"
    :id="razgo.id"
    :name="razgo.nombre"
    :description="razgo.descripcion"/>
  <p>
    <b>Precio: </b><MoneyDisplay :money="props.miscItem.precio" />, <b>Peso: </b><WeightDisplay :weight="props.miscItem.peso" />
  </p>
  <p>
    <b>Tipo: </b>{{ props.miscItem.tipo }}
  </p>
  <p>
    {{ props.miscItem.efecto }}
  </p>
</template>
<script setup>
import TraitTag from "./generic/TraitTag.vue";
import MoneyDisplay from "./generic/MoneyDisplay.vue";
import WeightDisplay from "./generic/WeightDisplay.vue";

const props = defineProps({
  miscItem: Object,
});
</script>