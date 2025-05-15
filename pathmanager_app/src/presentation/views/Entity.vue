<template>
  <CButtonGroup role="group">
    <CButton color="danger" @click="goBack"><RollbackOutlined />Regresar</CButton>
    <RouterLink :to="'/editar/' + props.id">
      <CButton color="secondary"><FormOutlined />Editar</CButton>
    </RouterLink>
  </CButtonGroup>
  <Suspense>
    <CharacterStats :id="props.id" />
    <template #fallback> Cargando Datos del Enemigo... </template>
  </Suspense>
</template>
<script setup>
import { useRouter } from "vue-router";
import { CButton, CButtonGroup } from "@coreui/vue";
import { FormOutlined, RollbackOutlined } from "@ant-design/icons-vue";
import CharacterStats from "../components/CharacterStats.vue";

const props = defineProps({
  id: Number,
});

const router = useRouter();

const goBack = () => {
  router.go(-1);
};
</script>
