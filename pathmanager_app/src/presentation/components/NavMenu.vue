<template>
    <a-page-header class="demo-page-header" title="Pathmanager" @back="() => $router.go(-1)">
      <template #extra>
        <a-button key="1" type="primary" danger>Salir</a-button>
      </template>
      <a-menu v-model:selectedKeys="selected" mode="horizontal" :items="menuItems" />
    </a-page-header>
</template>
<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { getBaseMenu } from '../support/MenuHandler';

const router = useRouter();

const menuSetup = getBaseMenu(1, router);
const selected = ref([menuSetup.selection]);
const menuItems = ref(menuSetup.menu);
</script>
<style scoped>
.demo-page-header :deep(tr:last-child td) {
  padding-bottom: 0;
  border: 1px solid rgb(235, 237, 240);
  position: relative;
  top: 0px;
  left: 0px;
  margin-bottom: 23px;
}
</style>