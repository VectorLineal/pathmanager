<template>
    <h5>Ataques:</h5>
    <p v-for="ataque in props.attacks"><GenericAction :name="ataque.nombre" :delay="ataque.demora">
        <template #content>
            {{ '+' + ataque.bono_ataque }}(
                <TraitTag
                    v-for="razgo in ataque.razgos"
                    :id="razgo.id"
                    :name="razgo.monto != null? razgo.nombre.replace(' x', ' '+ razgo.monto):razgo.nombre"
                    :description="razgo.monto != null? razgo.descripcion.replace('x', razgo.monto):razgo.descripcion"
                /><template v-if="ataque.alcance > 0"> alcance: {{ ataque.alcance }}</template>
            ) {{ ataque.tipo_dano + ' ' + ataque.monto }}<template v-if="ataque.efecto != null">, {{ ataque.efecto }}</template>
        </template>
    </GenericAction></p>
</template>
<script setup>
import GenericAction from './generic/GenericAction.vue';
import TraitTag from './generic/TraitTag.vue';
const props = defineProps({
    attacks: Array
});
</script>