<template>
    <h5>Ataques:</h5>
    <p v-for="ataque in props.attacks"><GenericAction :name="ataque.nombre" :delay="1">
        <template #content>
            {{ '+' + ataque.bono_ataque }}(

                <TraitAmountTag
                    v-for="razgo in ataque.razgos"
                    :id="razgo.id"
                    :nombre="razgo.nombre"
                    :descripcion="razgo.descripcion"
                    :monto="razgo.monto"
                /><template v-if="ataque.alcance > 0"> alcance: {{ ataque.alcance }}</template>
            ) {{ ataque.tipo_dano + ' ' + ataque.monto }}<template v-if="ataque.efecto != null">, {{ ataque.efecto }}</template>
        </template>
    </GenericAction></p>
</template>
<script setup>
import GenericAction from './generic/GenericAction.vue';
import TraitAmountTag from './generic/TraitAmountTag.vue';
const props = defineProps({
    attacks: Array
});
</script>