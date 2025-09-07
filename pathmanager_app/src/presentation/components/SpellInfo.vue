<template>
  <a @click="openModal" class="spell-text">{{ props.spell.nombre + '(' + props.spell.cantidad + ') ' }}</a>
  <a-modal v-model:open="isOpen" :footer="null">
    <template #title>
      <GenericAction :name="props.spell.nombre" :delay="props.spell.demora">
        <template #content>
          <strong>{{ '   ' + spellLevel }}</strong>
        </template>
      </GenericAction>
    </template>
    <SpellDetails :spell="props.spell"/>
  </a-modal>
</template>
<script setup>
import { ref, computed } from 'vue';
import SpellDetails from './SpellDetails.vue';
import GenericAction from './generic/GenericAction.vue';

const props = defineProps({
  spell: Object
});

const spellLevel = computed(() => {
  return props.spell.nivel == 0? 'Truco':('Hechizo ' + props.spell.nivel);
});

const isOpen = ref(false);

const openModal= () => {
  isOpen.value = true;
}
</script>
<style scoped>
.spell-text{
  color: #df13bf;
  font-weight: 500;
}
</style>