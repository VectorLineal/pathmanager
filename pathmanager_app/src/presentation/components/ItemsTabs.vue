<template>
  <a-tabs v-model:activeKey="activeKey" centered type="card">
    <a-tab-pane key="1" tab="Armas">
      <Suspense>
        <WeaponsTable />
        <template #fallback> Cargando Armas... </template>
      </Suspense>
    </a-tab-pane>
    <a-tab-pane key="2" tab="Armaduras">
      <ArmorTable />
    </a-tab-pane>
    <a-tab-pane key="3" tab="Escudos">
      <p>Escudos</p>
    </a-tab-pane>
    <a-tab-pane key="4" tab="Artefactos">
      <p>Artefactos</p>
    </a-tab-pane>
    <a-tab-pane key="5" tab="Vestimenta">
      <p>vestimenta</p>
    </a-tab-pane>
    <a-tab-pane key="6" tab="Consumibles">
      <p>consumibles</p>
    </a-tab-pane>
  </a-tabs>
</template>
<script setup>
import { ref } from "vue";
import WeaponsTable from "./WeaponsTable.vue";
import ArmorTable from "./ArmorTable.vue";
const activeKey = ref("1");
</script>
