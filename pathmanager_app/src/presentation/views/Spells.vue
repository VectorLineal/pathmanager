<template>
    <h3>Lista de Hechizos</h3>
    <Suspense>
        <SpellsTabs />
        <template #fallback>
            Cargando Hechizos...
        </template>
    </Suspense>
</template>
<script setup>
import SpellsTabs from '../components/SpellsTabs.vue';
</script>