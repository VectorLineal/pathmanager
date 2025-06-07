<template>
  <TraitAmountTag
                    v-for="razgo in weapon.razgos"
                    :id="razgo.id"
                    :nombre="razgo.nombre"
                    :descripcion="razgo.descripcion"
                    :monto="razgo.monto"
                />
  <p><b>Precio: </b><MoneyDisplay :money="props.weapon.precio"/>, <b>Peso: </b><WeightDisplay :weight="props.weapon.peso"/></p>
  <p><b>Daño: </b>{{ props.weapon.monto + ' ' + props.weapon.tipoDano}}<template v-if="props.weapon.bono > 0">, <b>Bono: </b>{{ '+' + props.weapon.bono }}</template></p>
  <p><b>Manos: </b>{{ props.weapon.manos }}<template v-if="props.weapon.alcance > 0">, <b>Alcance: </b> {{ props.weapon.alcance }}</template></p>
  <p ><b>Tipo: </b>{{ props.weapon.tipo }}, <b>Grupo: </b>{{ props.weapon.grupo }}, <b>Categoría: </b>{{ props.weapon.categoria }}</p>
  <p v-if="props.weapon.efecto != null && props.weapon.efecto != ''">{{ props.weapon.efecto }}</p>
  <p><b>Especialización de Crítico: </b>{{ props.weapon.especialidadCritico }}</p>
</template>
<script setup>
import TraitAmountTag from "./generic/TraitAmountTag.vue";
import MoneyDisplay from "./generic/MoneyDisplay.vue";
import WeightDisplay from "./generic/WeightDisplay.vue";

const props = defineProps({
  weapon: Object,
});
</script>