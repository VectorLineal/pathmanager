<template>
    <h3>Lista de Enemigos</h3>
    <Suspense>
        <EnemiesTable />
        <template #fallback>
            Cargando Enemigos...
        </template>
    </Suspense>
</template>
<script setup>
import EnemiesTable from '../components/EnemiesTable.vue';
</script>