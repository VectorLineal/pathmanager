<template>
  <a-tabs v-model:activeKey="activeKey" centered type="card">
    <a-tab-pane key="1" tab="Hechizos"
      ><Suspense>
        <SpellsTable :isFocus="false" />
        <template #fallback> Cargando Hechizos... </template>
      </Suspense>
    </a-tab-pane>
    <a-tab-pane key="2" tab="Hechizos de Foco"
      ><Suspense>
        <SpellsTable :isFocus="true" />
        <template #fallback> Cargando Hechizos de Foco... </template>
      </Suspense>
    </a-tab-pane>
  </a-tabs>
</template>
<script setup>
import { ref } from "vue";
import SpellsTable from "./SpellsTable.vue";
const activeKey = ref("1");
</script>
