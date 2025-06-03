<template>
    <h3>Lista de Hechizos</h3>
    <Suspense>
        <SpellsTable />
        <template #fallback>
            Cargando Hechizos...
        </template>
    </Suspense>
</template>
<script setup>
import SpellsTable from '../components/SpellsTable.vue';
</script>