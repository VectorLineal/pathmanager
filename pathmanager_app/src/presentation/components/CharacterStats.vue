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
                <MoneyDisplay :money="entity.dinero"/> <template v-if="entity.tesoro != null"><b>, tesoro: </b> {{ entity.tesoro }}</template>
            </p>
            <p>{{ entity.descripcion }}</p>
        </a-col>
    </a-row>
</template>
<script setup>
import { ref, computed } from 'vue';
import CharacterCard from './CharacterCard.vue';
import MappedWeakRes from './MappedWeakRes.vue';
import MappedAttacks from './MappedAttacks.vue';
import MappedAbilities from './MappedAbilities.vue';
import MoneyDisplay from './generic/MoneyDisplay.vue';
import SpellList from './SpellList.vue';
import { getEntity } from '../../logic/EntityOperations';

const props = defineProps({
    id: Number
});

const entity = ref();

const hasLoot = computed(() => {
    return entity.value.dinero > 0 || entity.value.tesoro != null
});

try{
    const response = await getEntity(props.id);
    entity.value = response;
    //console.log("loaded entity:", response);
}catch(error){
    console.error("error on fetch Enity", error);
}
</script>