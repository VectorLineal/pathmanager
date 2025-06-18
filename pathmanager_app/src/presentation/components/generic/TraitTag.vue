<template>
  <a-tag :key="props.id" color="green">
    <a-popover placement="top" :title="props.name" :content="props.description">
      <a>{{ props.name }}</a>
    </a-popover>
  </a-tag>
</template>
<script setup>
const props = defineProps({
    id: Number,
    name: String,
    description: String
});
</script>