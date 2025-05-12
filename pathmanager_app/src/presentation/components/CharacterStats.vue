<template>
    <a-row>
        <a-col >
            <CharacterCard :entity="entity"/>
        </a-col>
    </a-row>
</template>
<script setup>
import { ref } from 'vue';
import CharacterCard from './CharacterCard.vue';
import { getEntity } from '../../logic/EntityOperations';

const props = defineProps({
    id: Number
});

const entity = ref();

try{
    console.log("Character props:", props);
    const response = await getEntity(props.id);
    entity.value = response;
    console.log("loaded entity:", response);
}catch(error){
    console.error("error on fetch Enity", error);
}
</script>