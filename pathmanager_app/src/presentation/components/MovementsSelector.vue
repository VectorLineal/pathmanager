<template>
  <a-space
    v-for="(movement, index) in movements"
    :key="movement.movimientoId"
    class="list-field"
    align="baseline"
  >
    <a-select v-model:value="movement.movimientoId" placeholder="Movimiento" :options="movementsStorage.dataSelector" @change="triggerUpdate"/>
    <a-input-number v-model:value="movement.cantidad" :min="0" :max="150" @change="triggerUpdate"/>
    <MinusCircleOutlined @click="removeElement(index)" />
  </a-space>
  <a-button type="dashed" block @click="addElement">
    <PlusOutlined /> Añadir Movimiento
  </a-button>
</template>
<script setup>
import { ref } from "vue";
import { MinusCircleOutlined, PlusOutlined } from "@ant-design/icons-vue";
import { movementsStorage } from "../../logic/Storage";

const props = defineProps({
  initialData: Array,
});

const emit = defineEmits(['updatedValues']);

const movements = ref(props.initialData != null ? props.initialData : []);

const triggerUpdate = () => {
  emit('updatedValues', movements.value);
}

const removeElement = (index) => {
  if (index >= 0){
    movements.value.splice(index, 1);
    triggerUpdate();
  }
};
const addElement = () => {
  movements.value.push({
    movimientoId: null,
    cantidad: 0,
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
