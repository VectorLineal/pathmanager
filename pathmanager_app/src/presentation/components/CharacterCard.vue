<template>
  <a-card>
    <template #cover>
      <img alt="Retrato" :src="image" class="portait"/>
    </template>
    <template #title>
      <h5>{{entity.nombre}}</h5>
      <a-tag color="green">{{ entity.alineacion }}</a-tag>
      <a-tag color="cyan">{{ entity.raza }}</a-tag>
      <a-tag color="purple">{{ entity.tamano }}</a-tag>
      <a-tag color="blue">{{ entity.clase }}</a-tag>
    </template>
    <template #actions>
      <TraitTag
        v-for="razgo in entity.razgos"
        :id="razgo.id"
        :name="razgo.nombre"
        :description="razgo.descripcion"
      />
    </template>
    <a-card-meta>
      <template #title>
        <span
          ><b>XP: </b>{{ entity.experiencia }}, <b>CR: </b
          >{{ entity.nivel }}</span
        >
      </template>
      <template #description>
        <p>
          <b>Percepción: </b><Modifier :amount="entity.percepcion"/>, <b>Sentidos: </b
          ><template v-for="sentido in entity.sentidos"
            ><UExtraInfo
              :name="sentido.nombre"
              :description="sentido.descripcion"
            /><span v-if="sentido.rango != null">{{
              " " + sentido.rango
            }}</span></template
          >
        </p>
        <p>
          <b>lenguages: </b
          ><LangTag
            v-for="lenguage in entity.lenguages"
            :name="lenguage.nombre"
            :rarity="lenguage.rarezaId"
          />, <b>movilidad: </b
          ><MovInfo
            v-for="velocidad in entity.velocidades"
            :name="velocidad.nombre"
            :amount="velocidad.cantidad"
          />
        </p>
        <p>
          <b>AC: </b>{{ entity.AC }} <b clas="subindex">desprevenido: </b
          >{{ entity.FFAC }}, <b>HP: </b>{{ entity.salud }}<b>, fort: </b
          ><Modifier :amount="entity.fortaleza"/>, <b>ref: </b><Modifier :amount="entity.reflejos"/>,
          <b>will: </b><Modifier :amount="entity.voluntad"/>
        </p>
        <p>
          <b>str: </b><Modifier :amount="entity.fuerza"/>,
          <b>dex: </b><Modifier :amount="entity.destreza"/>,
          <b>con: </b><Modifier :amount="entity.constitucion"/>,
          <b>int: </b><Modifier :amount="entity.inteligencia"/>,
          <b>wis: </b><Modifier :amount="entity.sabiduria"/>,
          <b>cha: </b><Modifier :amount="entity.carisma"/>
        </p>
        <p>
          <ConditionalModifier name="acrobacia: " :amount="entity.acrobacia"/>
          <ConditionalModifier name="actuación: " :amount="entity.actuacion"/>
          <ConditionalModifier name="atletismo: " :amount="entity.atletismo"/>
          <ConditionalModifier name="diplomacia: " :amount="entity.diplomacia"/>
          <ConditionalModifier name="engaño: " :amount="entity.engano"/>
          <ConditionalModifier name="fabricación: " :amount="entity.fabricacion"/>
          <ConditionalModifier name="intimidación: " :amount="entity.intimidacion"/>
          <ConditionalModifier name="latrocinio: " :amount="entity.robo"/>
          <ConditionalModifier name="medicina: " :amount="entity.medicina"/>
          <ConditionalModifier name="naturaleza: " :amount="entity.naturaleza"/>
          <ConditionalModifier name="ocultismo: " :amount="entity.ocultismo"/>
          <ConditionalModifier name="religión: " :amount="entity.religion"/>
          <ConditionalModifier name="sigilo: " :amount="entity.sigilo"/>
          <ConditionalModifier name="sociedad: " :amount="entity.sociedad"/>
          <ConditionalModifier name="supervivencia: " :amount="entity.supervivencia"/>
          <ConditionalModifier name="tradición: " :amount="entity.tradicion"/>
        </p>
      </template>
    </a-card-meta>
  </a-card>
</template>
<script setup>
import { computed } from "vue";
import TraitTag from "./generic/TraitTag.vue";
import LangTag from "./generic/LangTag.vue";
import MovInfo from "./generic/MovInfo.vue";
import UExtraInfo from "./generic/UExtraInfo.vue";
import Modifier from "./generic/Modifier.vue";
import ConditionalModifier from "./generic/ConditionalModifier.vue";

const props = defineProps({
  entity: Object,
});

const image = computed(() => {
  return "/retratos/" + props.entity.raza + "/" + props.entity.nombre + ".png";
});
</script>
<style scoped>
.subindex {
  font-weight: 400;
}
.portait{
  margin-top: 13px;
}
</style>
