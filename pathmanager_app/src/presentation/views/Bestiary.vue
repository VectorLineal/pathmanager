<template>
    <h3>Lista de Enemigos</h3>
    <RouterLink to="/enemigoCrear">
      <CButton color="success"><UserAddOutlined />Añadir Entidad</CButton>
    </RouterLink>
    <Suspense>
        <EnemiesTable />
        <template #fallback>
            Cargando Enemigos...
        </template>
    </Suspense>
</template>
<script setup>
import { CButton } from "@coreui/vue";
import { UserAddOutlined } from "@ant-design/icons-vue";

import EnemiesTable from '../components/EnemiesTable.vue';
</script>