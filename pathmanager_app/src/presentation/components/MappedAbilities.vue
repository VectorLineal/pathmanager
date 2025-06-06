<template>
    <h5>Habilidades:</h5>
    <p v-for="habilidad in props.abilities">
        <GenericAction :name="habilidad.nombre" :delay="habilidad.demora">
            <template #content>
                <template v-if="habilidad.requisito"><b>requisito: </b>{{ habilidad.requisito + ' '}}</template>
                (
                    <TraitTag
                        v-for="razgo in habilidad.razgos"
                        :id="razgo.id"
                        :name="razgo.nombre"
                        :description="razgo.descripcion"
                    />
                )
                {{ habilidad.efecto }}
                <template v-if="habilidad.critico"><b> fallo crítico: </b>{{ habilidad.critico }}</template>
                <template v-if=" habilidad.alcance != 0"><b> alcance: </b>{{ habilidad.alcance == 1? ' contacto':(' ' + habilidad.alcance)}}</template>
            </template>
        </GenericAction>
    </p>
</template>
<script setup>
import GenericAction from './generic/GenericAction.vue';
import TraitTag from './generic/TraitTag.vue';
const props = defineProps({
    abilities: Array
});
console.log("input abilities:", props.abilities);
</script>