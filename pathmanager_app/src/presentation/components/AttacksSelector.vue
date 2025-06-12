<template>
  <a-space
    v-for="(weapon, index) in selectedWeapons"
    :key="weapon.armaId"
    class="list-field"
    align="baseline"
  >
    <a-select v-model:value="weapon.armaId" placeholder="Armas" :options="weapons" show-search :filter-option="filterOption" @change="selectWeapon"/>
    <a-input-number v-model:value="weapon.alcance" :min="1" :max="10" @change="triggerUpdate"/>
    <a-input v-model:value="weapon.monto" placeholder="Daño" @change="triggerUpdate"/>
    <a-input-number v-model:value="weapon.bono" :min="0" :max="20" @change="triggerUpdate"/>
    <a-textarea v-model:value="weapon.efecto" placeholder="efecto especial" @change="triggerUpdate"/>
    <a-select v-model:value="weapon.danoId" placeholder="Tipo de daño" :options="damageTypesStorage.dataSelector" @change="triggerUpdate"/>
    <MinusCircleOutlined @click="removeElement(index)" />
  </a-space>
  <a-button type="dashed" block @click="addElement">
    <PlusOutlined /> Añadir Ataque
  </a-button>
</template>
<script setup>
import { ref, inject } from "vue";
import { MinusCircleOutlined, PlusOutlined } from "@ant-design/icons-vue";
import { getWeaponBaseAttack } from "../../logic/WeaponOperations";
import { damageTypesStorage } from "../../logic/Storage";

const emit = defineEmits(['updatedValues']);

const {weapons, loadWeapons} = inject('weapons');

const selectedWeapons = ref([]);

const filterOption = (input, option) => {
  return option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0;
};

const triggerUpdate = () => {
  emit('updatedValues', selectedWeapons.value);
};

const selectWeapon = async (value, option) => {
    const weaponData = await getWeaponBaseAttack(value);
    for (let index = 0; index < selectedWeapons.value.length; index++) {
        if(selectedWeapons.value[index].armaId == value){
            //monto, alcance, efecto, bono, danoId
            selectedWeapons.value[index].monto = weaponData.monto;
            selectedWeapons.value[index].alcance = weaponData.alcance;
            selectedWeapons.value[index].efecto = weaponData.efecto;
            selectedWeapons.value[index].bono = weaponData.bono;
            selectedWeapons.value[index].danoId = weaponData.danoId;
        }
    }
    triggerUpdate();
};

const removeElement = (index) => {
  if (index >= 0){
    selectedWeapons.value.splice(index, 1);
    triggerUpdate();
  }
};
const addElement = () => {
  selectedWeapons.value.push({
    armaId: null,
    alcance: 0,
    monto: '1d4',
    efecto: null,
    bono: 0,
    danoId: null
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