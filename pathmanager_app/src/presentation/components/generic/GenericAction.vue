<template>
    <b>{{ props.name + ' ' }}</b>
    <RollbackOutlined v-if="props.delay == -1"/>
    <MinusSquareOutlined v-else-if="props.delay == 0"/>
    <RightSquareOutlined v-else-if="props.delay < 6 && props.delay > 0" v-for="num in props.delay"/>
    <span v-else-if="props.delay >= 6">{{ Math.ceil(props.delay / 30) }} minutos</span>
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