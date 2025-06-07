<template>
    <h3>Litas de Items</h3>
    <Suspense>
        <ItemsTabs />
        <template #fallback>
            Cargando Items...
        </template>
    </Suspense>
</template>
<script setup>
import ItemsTabs from '../components/ItemsTabs.vue';
</script>