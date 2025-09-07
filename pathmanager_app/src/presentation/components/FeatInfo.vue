<template>
  <a @click="openModal" class="feat-text">{{ props.feat.nombre }}</a>
  <a-modal v-model:open="isOpen" :footer="null" :title="featLevel">
    <FeatDetails :feat="props.feat"/>
  </a-modal>
</template>
<script setup>
import { ref, computed } from 'vue';
import FeatDetails from './FeatDetails.vue';

const props = defineProps({
  feat: Object
});

const featLevel = computed(() => {
  return props.feat.nombre + '   ' + props.feat.nivel;
});

const isOpen = ref(false);

const openModal= () => {
  isOpen.value = true;
}
</script>
<style scoped>
.feat-text{
  color: #39bf13;
  font-weight: 500;
}
</style>