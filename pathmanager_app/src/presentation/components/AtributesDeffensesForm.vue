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
          <a-input-number v-model:value="formState.con" :min="-5" :max="50" />
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
        <a-form-item label="Atletismo" name="atletism">
          <a-input-number v-model:value="formState.atletism" :min="0" :max="50" />
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
    <a-row justify="space-around">
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Armadura Natural" name="naturalArmor">
          <a-input-number v-model:value="formState.naturalArmor" :min="10" :max="150" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Armadura de Ítem" name="itemArmor">
          <a-input-number v-model:value="formState.itemArmor" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Evasión" name="dodge">
          <a-input-number v-model:value="formState.dodge" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Salud" name="health">
          <a-input-number v-model:value="formState.health" :min="10" :max="5000" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Percepción" name="perception">
          <a-input-number v-model:value="formState.perception" :min="0" :max="50" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Fortaleza" name="fort">
          <a-input-number v-model:value="formState.fort" :min="0" :max="100" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Reflejos" name="reflex">
          <a-input-number v-model:value="formState.reflex" :min="0" :max="100" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Voluntad" name="will">
          <a-input-number v-model:value="formState.will" :min="0" :max="100" />
        </a-form-item>
      </a-col>
      <a-col :sm="4" :md="3" :lg="3" :xl="2">
        <a-form-item label="Ataque" name="attackBonus">
          <a-input-number v-model:value="formState.attackBonus" :min="0" :max="100" />
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
  acrobatics: props.intialData != null? props.intialData.acrobatics:0,
  arcana: props.intialData != null? props.intialData.arcana:0,
  atletism: props.intialData != null? props.intialData.atletism:0,
  crafting: props.intialData != null? props.intialData.crafting:0,
  deceiving: props.intialData != null? props.intialData.deceiving:0,
  diplomacy: props.intialData != null? props.intialData.diplomacy:0,
  intimidation: props.intialData != null? props.intialData.intimidation:0,
  lore: props.intialData != null? props.intialData.lore:0,
  medicine: props.intialData != null? props.intialData.medicine:0,
  nature: props.intialData != null? props.intialData.nature:0,
  ocultism: props.intialData != null? props.intialData.ocultism:0,
  performance: props.intialData != null? props.intialData.performance:0,
  religion: props.intialData != null? props.intialData.religion:0,
  society: props.intialData != null? props.intialData.society:0,
  stealth: props.intialData != null? props.intialData.stealth:0,
  survival: props.intialData != null? props.intialData.survival:0,
  thievery: props.intialData != null? props.intialData.thievery:0,
  naturalArmor: props.intialData != null? props.intialData.naturalArmor:0,
  itemArmor: props.intialData != null? props.intialData.itemArmor:0,
  dodge: props.intialData != null? props.intialData.dodge:0,
  health: props.intialData != null? props.intialData.health:0,
  perception: props.intialData != null? props.intialData.perception:0,
  attackBonus: props.intialData != null? props.intialData.attackBonus:0,
  fort: props.intialData != null? props.intialData.fort:0,
  reflex: props.intialData != null? props.intialData.reflex:0,
  will: props.intialData != null? props.intialData.will:0
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
