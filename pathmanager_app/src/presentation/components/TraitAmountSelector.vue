<template>
  <a-space
    v-for="(trait, index) in traits"
    :key="trait.id"
    class="list-field"
    align="baseline"
  >
    <a-select v-model:value="trait.id" placeholder="Razgo" :options="traitsStorage.dataSelector" @select="triggerUpdate"/>
    <a-input-number v-model:value="trait.monto" :min="-50" :max="50" @change="triggerUpdate"/>
    <MinusCircleOutlined @click="removeElement(index)" />
  </a-space>
  <a-button type="dashed" block @click="addElement">
    <PlusOutlined /> Añadir Razgo
  </a-button>
</template>
<script setup>
import { ref } from "vue";
import { MinusCircleOutlined, PlusOutlined } from "@ant-design/icons-vue";
import { traitsStorage } from "../../logic/Storage";

const props = defineProps({
  initialData: Array,
});

const emit = defineEmits(['updatedValues']);

const traits = ref(props.initialData != null ? props.initialData : []);

const triggerUpdate = () => {
  emit('updatedValues', traits.value);
}

const removeElement = (index) => {
  if (index >= 0){
    traits.value.splice(index, 1);
    triggerUpdate();
  }
};
const addElement = () => {
  traits.value.push({
    id: null,
    monto: null,
  });
  triggerUpdate();
};
</script>
<style scoped>
.list-field {
  display: flex;
  margin-bottom: 8px;
}
</style>