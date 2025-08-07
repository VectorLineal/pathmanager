<template>
  <a-form
    layout="vertical"
    :model="formState"
    ref="formRef"
    :rules="rules"
    :label-col="labelCol"
    :wrapper-col="wrapperCol"
  >
    <a-row justify="space-around" align="middle">
      <a-col :sm="24">
        <a-form-item label="Ataques" name="attacks">
          <AttacksSelector @updatedValues="selectAttacks" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Habilidades Especiales" name="abilities">
          <SpecialAbilitySelector @onSelect="selectAbilities" />
        </a-form-item>
      </a-col>
      <a-col :sm="8" :md="7" :lg="7" :xl="5" v-if="mayCastSpells">
        <a-form-item label="Hechizos" name="inmunities">
          <SpellsSelector @updatedValues="selectSpells" />
        </a-form-item>
      </a-col>
    </a-row>
  </a-form>
</template>
<script setup>
import { reactive, ref, toRaw, inject, computed } from "vue";
import AttacksSelector from "../selectors/AttacksSelector.vue";
import SpellsSelector from "../selectors/SpellsSelector.vue";
import SpecialAbilitySelector from "../selectors/SpecialAbilitySelector.vue";

const emit = defineEmits(["updateData"]);

const {availableSpells, loadSpells} = inject('spells');

const mayCastSpells = computed(() => {
    return availableSpells.value.length > 0;
});

const formState = reactive({
  abilities: [],
  attacks: [],
  spells: []
});
const formRef = ref();
const labelCol = {
  span: 24,
};
const wrapperCol = {
  span: 24,
};

const rules = {
  attacks: [
    {
      type: 'array',
      required: true,
      message: "Agregue al menos un ataque",
      trigger: "change",
    },
  ]
};

const selectAbilities = (value) => {
  formState.abilities = value;
};
const selectAttacks = (value) => {
  formState.attacks = value;
};
const selectSpells = (value) => {
  formState.spells = value;
};

const validateAndUpdate = async () => {
  try {
    await formRef.value.validate();
    emit("updateData", toRaw(formState), true);
  } catch (error) {
    emit("updateData", {}, false);
    return;
  }
};
defineExpose({ validateAndUpdate });
</script>