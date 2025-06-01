<template>
    <a-row>
        <a-col :span="10">
            <CharacterCard :entity="entity"/>
        </a-col>
        <a-col :span="14">
            <p><b>Inmunidades: </b><b v-for="inmunidad in entity.inmunidades">{{ inmunidad.nombre + ' ' }}</b></p>
            <MappedWeakRes :resistances="entity.resistencias"/>
            <MappedAttacks :attacks="entity.ataques"/>
            <MappedAbilities :abilities="entity.habilidades"/>
            <SpellList v-if="entity.hechizos.length > 0" :spells="entity.hechizos"/>
            <p v-if="hasLoot">
                <DollarCircleFilled :style="goldStyle"/>{{ money.gold }}, <DollarCircleFilled :style="silverStyle"/>{{ money.silver }}, <DollarCircleFilled :style="copperStyle"/>{{ money.coopper }}, <template v-if="entity.tesoro != null"><b>tesoro: </b> {{ entity.tesoro }}</template>
            </p>
            <p>{{ entity.descripcion }}</p>
        </a-col>
    </a-row>
</template>
<script setup>
import { ref, computed } from 'vue';
import { DollarCircleFilled } from '@ant-design/icons-vue';
import CharacterCard from './CharacterCard.vue';
import MappedWeakRes from './MappedWeakRes.vue';
import MappedAttacks from './MappedAttacks.vue';
import MappedAbilities from './MappedAbilities.vue';
import SpellList from './SpellList.vue';
import { getEntity } from '../../logic/EntityOperations';

const props = defineProps({
    id: Number
});

const entity = ref();

const hasLoot = computed(() => {
    return entity.value.dinero > 0 || entity.value.tesoro != null
});

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
    let curMoney = entity.value.dinero;
    const coopper = curMoney % 100;
    curMoney /= 100;
    const silver = curMoney % 100;
    curMoney /= 100;
    const gold = Math.floor(curMoney);

    return{gold, silver, coopper};
});

try{
    console.log("Character props:", props);
    const response = await getEntity(props.id);
    entity.value = response;
    console.log("loaded entity:", response);
}catch(error){
    console.error("error on fetch Enity", error);
}
</script>