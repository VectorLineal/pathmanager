<template>
  <p v-for="spellLevel in orderedSpells">
    <b>{{
      (spellLevel[0].nivel == 0 ? "Trucos" : "Hechizos " + spellLevel[0].nivel_final) + ': '
    }}</b>
    <SpellInfo v-for="spell in spellLevel" :spell="spell" />
  </p>
</template>
<script setup>
import { ref, computed } from "vue";
import SpellInfo from "./SpellInfo.vue";

const props = defineProps({
  spells: Array,
});

const orderedSpells = computed(() => {
  if(props.spells.length == 0) return [];
  const ordered = [];
  let row = [];
  let level = props.spells[0].nivel_final;
  for (let i = 0; i < props.spells.length; i++) {
    const spell = props.spells[i];
    if (spell.nivel_final == level) row.push(spell);
    else {
      if(row.length > 0) ordered.push(row);
      row = [spell];
      level++;
    }
  }
  ordered.push(row);
  return ordered;
});


</script>
