<template>
  <a-descriptions :title="props.title">
    <a-descriptions-item v-for="desc in props.data" :label="desc.label">
      {{desc.value}}
    </a-descriptions-item>
  </a-descriptions>
</template>
<script setup>
const props = defineProps({
  data: Array,
  title: String
});
</script>