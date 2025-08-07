<template>
    <CButton color="danger" @click="$router.go(-1)"><RollbackOutlined />Cancelar</CButton>
    <h3>Crear Personaje Jugable</h3>
</template>
<script setup>
import { CButton } from '@coreui/vue';
import { RollbackOutlined } from '@ant-design/icons-vue';
</script>