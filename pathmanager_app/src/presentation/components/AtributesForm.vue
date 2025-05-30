<template>
  <a-form
    layout="vertical"
    :model="formState"
    ref="formRef"
    :label-col="labelCol"
    :wrapper-col="wrapperCol"
  >
    <a-row justify="space-around">
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Fuerza" name="str">
          <a-input-number v-model:value="formState.str" :min="-5" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Destreza" name="dex">
          <a-input-number v-model:value="formState.dex" :min="-5" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Constitución" name="con">
          <a-input-number v-model:value="formState.str" :min="-5" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Inteligencia" name="int">
          <a-input-number v-model:value="formState.int" :min="-5" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Sabiduría" name="wis">
          <a-input-number v-model:value="formState.wis" :min="-5" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Carisma" name="cha">
          <a-input-number v-model:value="formState.cha" :min="-5" :max="50" />
        </a-form-item>
      </a-col>
    </a-row>
    <a-row justify="space-around">
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Acrobacia" name="acrobatics">
          <a-input-number v-model:value="formState.acrobatics" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Arcana" name="arcana">
          <a-input-number v-model:value="formState.arcana" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Atletismo" name="athletism">
          <a-input-number v-model:value="formState.athletism" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Fabricación" name="crafting">
          <a-input-number v-model:value="formState.crafting" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Engaño" name="deceiving">
          <a-input-number v-model:value="formState.deceiving" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Diplomacia" name="diplomacy">
          <a-input-number v-model:value="formState.diplomacy" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Intimidación" name="intimidation">
          <a-input-number v-model:value="formState.intimidation" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Tradición" name="lore">
          <a-input-number v-model:value="formState.lore" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Medicina" name="medicine">
          <a-input-number v-model:value="formState.medicine" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Naturaleza" name="nature">
          <a-input-number v-model:value="formState.nature" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Ocultismo" name="ocultism">
          <a-input-number v-model:value="formState.ocultism" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Actuación" name="performance">
          <a-input-number v-model:value="formState.performance" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Religión" name="religion">
          <a-input-number v-model:value="formState.religion" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Sociedad" name="society">
          <a-input-number v-model:value="formState.society" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Sigilo" name="stealth">
          <a-input-number v-model:value="formState.stealth" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Supervivencia" name="survival">
          <a-input-number v-model:value="formState.survival" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Latrocinio" name="thievery">
          <a-input-number v-model:value="formState.thievery" :min="0" :max="50" />
        </a-form-item>
      </a-col>
    </a-row>
  </a-form>
</template>
<script setup>
import { reactive, ref, toRaw } from "vue";

const emit = defineEmits(["updateData"]);

const props = defineProps({
  intialData: Object
});

const formState = reactive({
  str: props.intialData != null? props.intialData.str:0,
  dex: props.intialData != null? props.intialData.dex:0,
  con: props.intialData != null? props.intialData.con:0,
  int: props.intialData != null? props.intialData.int:0,
  wis: props.intialData != null? props.intialData.wis:0,
  cha: props.intialData != null? props.intialData.cha:0,
  acrobatics: 0,
  arcana: 0,
  athletism: 0,
  crafting: 0,
  deceiving: 0,
  diplomacy: 0,
  intimidation: 0,
  lore: 0,
  medicine: 0,
  nature: 0,
  ocultism: 0,
  performance: 0,
  religion: 0,
  society: 0,
  stealth: 0,
  survival: 0,
  thievery: 0
});
const formRef = ref();
const labelCol = {
  span: 24,
};
const wrapperCol = {
  span: 24,
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
