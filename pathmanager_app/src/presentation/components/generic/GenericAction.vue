<template>
    <b>{{ props.name + ' ' }}</b>
    <RollbackOutlined v-if="props.delay == -1"/>
    <MinusSquareOutlined v-else-if="props.delay == 0"/>
    <RightSquareOutlined v-else-if="props.delay > 0" v-for="num in props.delay"/>
    <slot name="content">
    </slot >
</template>
<script setup>
import { RightSquareOutlined, MinusSquareOutlined, RollbackOutlined } from '@ant-design/icons-vue';
const props = defineProps({
    delay: Number,
    name: String
});
</script>