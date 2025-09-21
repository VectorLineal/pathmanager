<template>
    <CButton color="danger" @click="$router.go(-1)"><RollbackOutlined />Cancelar</CButton>
    <h3>Crear Personaje</h3>
    <Suspense>
        <CharacterCreationSteps/>
        <template #fallback> Cargando Datos para la creación de Personaje... </template>
    </Suspense>
</template>
<script setup>
import { CButton } from '@coreui/vue';
import { RollbackOutlined } from '@ant-design/icons-vue';
import CharacterCreationSteps from "../components/CharacterCreationSteps.vue";
</script>