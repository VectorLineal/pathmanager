<template>
  <CButton color="danger" @click="goBack"><RollbackOutlined />Cancelar</CButton>
  <EntityCreationSteps/>
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