<template>
    <a-popover placement="top" :title="props.name" :content="props.description">
      <u class="overinfo">{{ props.name }}</u>
    </a-popover>
</template>
<script setup>
const props = defineProps({
    name: String,
    description: String
});
</script>