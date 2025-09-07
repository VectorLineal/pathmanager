<template>
  <TraitTag
    v-for="razgo in feat.razgos"
    :id="razgo.id"
    :name="razgo.nombre"
    :description="razgo.descripcion"
  />
  <p>{{ props.feat.descripcion }}</p>
  <p v-if="props.feat.requisito"><b>Requisito: </b>{{ props.feat.requisito }}</p>
  <p v-if="props.feat.desbloquea.length > 0"><b>Desbloquea: </b>{{ unlockText }}</p>
</template>
<script setup>
import { computed } from "vue";
import TraitTag from "./generic/TraitTag.vue";

const props = defineProps({
  feat: Object,
});
const unlockText = computed(() => {
    let feats = '';
    props.feat.desbloquea.forEach((element, index) => {
        feats += element;
        feats += index < props.feat.desbloquea.length - 1? ', ':'.';
    });
    return feats;
})
</script>
