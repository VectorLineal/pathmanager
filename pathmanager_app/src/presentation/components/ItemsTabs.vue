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
      <ShieldTable />
    </a-tab-pane>
    <a-tab-pane key="4" tab="Vestimenta">
      <MiscItemTable :itemType="0"/>
    </a-tab-pane>
    <a-tab-pane key="5" tab="Consumibles">
      <MiscItemTable :itemType="1"/>
    </a-tab-pane>
    <a-tab-pane key="6" tab="Artefactos">
      <MiscItemTable :itemType="2"/>
    </a-tab-pane>
  </a-tabs>
</template>
<script setup>
import { ref } from "vue";
import WeaponsTable from "./WeaponsTable.vue";
import ArmorTable from "./ArmorTable.vue";
import ShieldTable from "./ShieldTable.vue";
import MiscItemTable from "./MiscItemTable.vue";
const activeKey = ref("1");
</script>
