<template>
  <CButton color="danger" @click="goBack"><RollbackOutlined />Cancelar</CButton>
  <Suspense>
    <EntityCreationSteps/>
    <template #fallback> Cargando Datos para la creación de Enemigo... </template>
  </Suspense>
</template>
<script setup>
import { useRouter } from "vue-router";
import { CButton } from "@coreui/vue";
import { RollbackOutlined } from "@ant-design/icons-vue";
import EntityCreationSteps from "../components/EntityCreationSteps.vue";

const props = defineProps({
  id: Number,
});

const router = useRouter();

const goBack = () => {
  router.go(-1);
};
</script>