<template>
  <b>{{ ' ' + props.name + ': '}}</b>{{ props.amount }}
</template>
<script setup>
const props = defineProps({
    name: String,
    amount: String
});
</script>