<template>
  <GenericAction :name="props.ability.nombre" :delay="props.ability.demora">
    <template #content>
      <template v-if="props.ability.requisito">
        <b>requisito: </b>{{ props.ability.requisito + " " }}
      </template>
      (<TraitTag
        v-for="razgo in props.ability.razgos"
        :id="razgo.id"
        :name="razgo.nombre"
        :description="razgo.descripcion"
      />)
      {{ props.ability.efecto }}
      <template v-if="props.ability.critico">
        <b> fallo crítico: </b>{{ props.ability.critico }}
      </template>
      <template v-if="props.ability.alcance != 0">
        <b> alcance: </b>{{props.ability.alcance == 1 ? " contacto" : " " + props.ability.alcance }}
      </template>
    </template>
  </GenericAction>
</template>
<script setup>
import GenericAction from "./generic/GenericAction.vue";
import TraitTag from "./generic/TraitTag.vue";
const props = defineProps({
  ability: Object,
});
</script>
