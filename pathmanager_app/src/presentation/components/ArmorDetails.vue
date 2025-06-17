<template>
  <TraitTag
    v-for="razgo in armor.razgos"
    :id="razgo.id"
    :name="razgo.nombre"
    :description="razgo.descripcion"/>
  <p>
    <b>Precio: </b><MoneyDisplay :money="props.armor.precio" />, <b>Peso: </b><WeightDisplay :weight="props.armor.peso" />
  </p>
  <p>
    <b>Armadura: </b>{{ props.armor.ac }}, <b>Límite de destreza: </b>{{ "+" + props.armor.limite }}
  </p>
  <p>
    <b>Requisito de Fuerza: </b>{{ props.armor.requisito }}, <b>Penalización de dados: </b> {{ props.armor.penalizacion }}, <b>Penalización de velocidad: </b> {{ props.armor.velocidad }}
  </p>
  <p v-if="hasSavings">
    <b>Fortaleza: </b>{{ props.armor.fortaleza }}, <b>Reflejos: </b> {{ props.armor.reflejos }}, <b>Voluntad: </b> {{ props.armor.voluntad }}
  </p>
  <p>
    <b>Grupo: </b>{{ props.armor.grupo }}, <b>Categoría: </b>{{ props.armor.categoria }}
  </p>
  <p v-if="props.armor.efecto != null && props.armor.efecto != ''">
    {{ props.armor.efecto }}
  </p>
  <p>
    <b>Especialización de Armadura: </b>{{ props.armor.especialidadCritico }}
  </p>
</template>
<script setup>
import { computed } from "vue";
import TraitTag from "./generic/TraitTag.vue";
import MoneyDisplay from "./generic/MoneyDisplay.vue";
import WeightDisplay from "./generic/WeightDisplay.vue";

const props = defineProps({
  armor: Object,
});

const hasSavings = computed(() => {
    return props.armor.fortaleza > 0 || props.armor.reflejos > 0 || props.armor.voluntad > 0;
})
</script>
