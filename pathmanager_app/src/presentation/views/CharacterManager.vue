<template>
    <CButtonToolbar class="justify-content-center">
        <CButton color="primary" variant="outline">
            Mis Personajes
        </CButton>
        <CButton color="secondary" variant="outline">
            Asociar Personajes
        </CButton>
        <RouterLink to="/personajeCrear">
            <CButton color="success" variant="outline">
                Crear Personaje
            </CButton>
        </RouterLink>
    </CButtonToolbar>
</template>
<script setup>
import { CButton, CButtonToolbar } from '@coreui/vue';
</script>