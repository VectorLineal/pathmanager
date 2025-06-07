<template>
    <template v-if="money.gold > 0"><DollarCircleFilled :style="goldStyle" />{{ money.gold }}</template><template v-if="money.silver > 0"><DollarCircleFilled :style="silverStyle"/>{{ money.silver }}</template><template v-if="money.coopper > 0"><DollarCircleFilled :style="copperStyle"/>{{ money.coopper }}</template>
</template>
<script setup>
import { computed } from 'vue';
import { DollarCircleFilled } from '@ant-design/icons-vue';

const props = defineProps({
    money: Number
})

const goldStyle = {
    color: '#efb810'
};
const silverStyle = {
    color: '#c3c4c5'
};
const copperStyle = {
    color: '#cd7f32'
};

const money = computed(() => {
    let curMoney = props.money;
    const coopper = curMoney % 100;
    curMoney /= 100;
    const silver = curMoney % 100;
    curMoney /= 100;
    const gold = Math.floor(curMoney);

    return{gold, silver, coopper};
});
</script>