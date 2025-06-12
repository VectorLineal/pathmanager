<template>
  <h5>{{ props.spell.escuela }}</h5>
  <TraitTag
    v-for="razgo in spell.razgos"
    :id="razgo.id"
    :name="razgo.nombre"
    :description="razgo.descripcion"
  />
  <p v-if="props.spell.clase == null"><b>Tradiciones: </b><a v-for="tradicion in spell.tradiciones">{{ tradicion.nombre + ' ' }}</a></p>
  <p v-else><b>Clase: </b>{{ props.spell.clase }}</p>
  <p><template v-if="props.spell.alcance > 0"><b>Alcance: </b> {{ range }}, </template><b>Blancos: </b>{{ props.spell.blancos }}</p>
  <p>{{ props.spell.efecto }}</p>
  <p v-if="props.spell.fallo"><b>Salvación: </b>{{ props.spell.fallo }}</p>
  <p v-if="props.spell.critico"><b>Fallo crítico: </b>{{ props.spell.critico }}</p>
  <p v-if="props.spell.aumentos"><b>Aumentos: </b><p v-for="height in heightened">{{ height }}</p></p>
</template>
<script setup>
import { computed } from "vue";
import TraitTag from "./generic/TraitTag.vue";

const props = defineProps({
  spell: Object,
});

const range = computed(() => {
  return props.spell.alcance == 1? 'contacto': props.spell.alcance;
});
const heightened = computed(() => {
  return props.spell.aumentos.split(';');
})
</script>
