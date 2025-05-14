<template>
  <p v-for="spellLevel in ordered">
    <b>{{
      (spellLevel[0].nivel == 0 ? "Trucos" : "Hechizos " + spellLevel[0].nivel) + ': '
    }}</b>
    <SpellInfo v-for="spell in spellLevel" :spell="spell" />
  </p>
</template>
<script setup>
import { ref } from "vue";
import SpellInfo from "./SpellInfo.vue";

const props = defineProps({
  spells: Array,
});

const ordered = ref([]);
let row = [];
let level = 0;
for (let i = 0; i < props.spells.length; i++) {
  const spell = props.spells[i];
  if (spell.nivel_final == level) row.push(spell);
  else {
    ordered.value.push(row);
    row = [spell];
    level++;
  }
}
ordered.value.push(row);
</script>
