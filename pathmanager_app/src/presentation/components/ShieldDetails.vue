<template>
  <TraitAmountTag
    v-for="razgo in shield.razgos"
    :id="razgo.id"
    :nombre="razgo.nombre"
    :descripcion="razgo.descripcion"
    :monto="razgo.monto"/>
  <p>
    <b>Precio: </b><MoneyDisplay :money="props.shield.precio" />, <b>Peso: </b><WeightDisplay :weight="props.shield.peso" />
  </p>
  <p>
    <b>Armadura: </b>{{ props.shield.ac }}, <b>Salud: </b>{{ props.shield.salud }}, <b>Dureza: </b>{{ props.shield.dureza }}
  </p>
  <p v-if="props.shield.velocidad != 0">
    <b>Penalización de velocidad: </b> {{ props.shield.velocidad }}
  </p>
  <p v-if="hasSavings">
    <b>Fortaleza: </b>{{ props.shield.fortaleza }}, <b>Reflejos: </b> {{ props.shield.reflejos }}, <b>Voluntad: </b> {{ props.shield.voluntad }}
  </p>
  <p v-if="props.shield.efecto != null && props.shield.efecto != ''">
    {{ props.shield.efecto }}
  </p>
</template>
<script setup>
import { computed } from "vue";
import TraitAmountTag from "./generic/TraitAmountTag.vue";
import MoneyDisplay from "./generic/MoneyDisplay.vue";
import WeightDisplay from "./generic/WeightDisplay.vue";

const props = defineProps({
  shield: Object,
});

const hasSavings = computed(() => {
    return props.shield.fortaleza > 0 || props.shield.reflejos > 0 || props.shield.voluntad > 0;
})
</script>