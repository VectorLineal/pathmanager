<template>
  <a-form
    layout="vertical"
    :model="formState"
    ref="formRef"
    :rules="rules"
    :label-col="labelCol"
    :wrapper-col="wrapperCol"
  >
    <a-row justify="space-around">
      <a-col :sm="8" :md="7" :lg="6" :xl="5">
        <a-form-item label="Nombre" name="nombre">
          <a-input v-model:value="formState.nombre" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="5">
        <a-form-item label="Nivel" name="nivel">
          <a-input-number v-model:value="formState.nivel" :min="0" :max="10" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="5">
        <a-form-item label="Acciones" name="demora">
          <a-input-number v-model:value="formState.demora" :min="-1" :max="300" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="5">
        <a-form-item label="Alcance" name="alcance">
          <a-input-number v-model:value="formState.alcance" :min="0" :max="1000" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="6" :xl="6">
        <a-form-item label="Blancos" name="blancos">
          <TargetSelector @onSelect="selectTarget" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Escuela" name="escuela">
          <SchoolSelector @onSelect="selectSchool" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4" v-if="props.isFocus">
        <a-form-item label="Clase" name="clase">
          <ClassSelector @onSelect="selectClass" />
        </a-form-item>
      </a-col>
      <a-col :sm="8" :md="7" :lg="7" :xl="5" v-else>
        <a-form-item label="Tradiciones" name="traditions">
          <TraditionsSelector @onSelect="selectTraditions" />
        </a-form-item>
      </a-col>
      <a-col :sm="8" :md="7" :lg="7" :xl="5">
        <a-form-item label="Razgos" name="traits">
          <TraitsSelector @onSelect="selectTraits" />
        </a-form-item>
      </a-col>
    </a-row>
    <a-row justify="center">
      <a-col :xs="24" :sm="24" :lg="12">
        <a-form-item label="Efecto" name="efecto">
          <a-textarea v-model:value="formState.efecto" />
        </a-form-item>
      </a-col>
      <a-col :xs="24" :sm="24" :lg="12">
        <a-form-item label="Aumentos" name="aumentos">
          <a-textarea v-model:value="formState.aumentos" />
        </a-form-item>
      </a-col>
      <a-col :xs="24" :sm="24" :lg="12">
        <a-form-item label="Salvación" name="fallo">
          <a-textarea v-model:value="formState.fallo" />
        </a-form-item>
      </a-col>
      <a-col :xs="24" :sm="24" :lg="12">
        <a-form-item label="Fallo crítico" name="critico">
          <a-textarea v-model:value="formState.critico" />
        </a-form-item>
      </a-col>
    </a-row>
  </a-form>
  <CButtonToolbar role="group" aria-label="Toolbar with button groups">
    <CButtonGroup role="group" aria-label="First group">
      <CButton color="danger" @click="closeModal">Cancelar</CButton>
    </CButtonGroup>
    <CButtonGroup role="group" aria-label="Second group">
      <CButton color="success" @click="onCreation">Crear</CButton>
    </CButtonGroup>
  </CButtonToolbar>
</template>
<script setup>
import { reactive, ref, toRaw } from "vue";
import { CButton, CButtonGroup, CButtonToolbar } from "@coreui/vue";
import { message } from "ant-design-vue";
import Spell from "../../data/models/Spell";
import FocusSpell from "../../data/models/FocusSpell";
import { createSpell } from "../../logic/SpellOperations";
import SchoolSelector from "./SchoolSelector.vue";
import TargetSelector from "./TargetSelector.vue";
import TraditionsSelector from "./TraditionsSelector.vue";
import TraitsSelector from "./TraitsSelector.vue";
import ClassSelector from "./ClassSelector.vue";

const emit = defineEmits(["onSubmit", "onCancel"]);

const props = defineProps({
  isFocus: Boolean
});

const formState = reactive(props.isFocus? new FocusSpell(): new Spell());
const formRef = ref();
const labelCol = {
  span: 24,
};
const wrapperCol = {
  span: 24,
};

const checkLevel = async (_rule, value) => {
  if (value == null) {
    return Promise.reject("Escriba un nivel");
  }
  if (!Number.isInteger(value)) {
    return Promise.reject("EL nivel debe ser un número entero");
  } else {
    if (value < 0) {
      return Promise.reject("El nivel mínimo es 0");
    } else if (value > 25) {
      return Promise.reject("El máximo es 25");
    } else {
      return Promise.resolve();
    }
  }
};

const rules = {
  level: [
    {
      validator: checkLevel,
      trigger: "change",
    },
  ],
  blancoId: [
    {
      required: true,
      message: "Seleccione una blanco válido",
      trigger: "change",
    },
  ],
  escuelaId: [
    {
      required: true,
      message: "Seleccione una escuela",
      trigger: "change",
    },
  ],
  alineacion: [
    {
      required: true,
      message: "Seleccione una alineación",
      trigger: "change",
    },
  ],
  claseId: [
    {
      required: props.isFocus,
      message: "Seleccione una alineación",
      trigger: "change",
    },
  ],
  name: [
    {
      whitespace: true,
      required: true,
      message: "Escriba un nombre",
      trigger: "change",
    },
  ],
  efecto: [
    {
      whitespace: true,
      required: true,
      message: "El hehcizo debe tener un efecto",
      trigger: "change",
    },
  ],
  traditions: [
    {
      type: 'array',
      required: true,
      message: "El hehcizo debe tener al menos una tradición",
      trigger: "change",
    },
  ],
};

const selectSchool = (value) => {
  formState.escuelaId = value;
};
const selectTarget = (value) => {
  formState.blancoId = value;
};
const selectTraits = (value) => {
  formState.traits = value;
};
const selectTraditions = (value) => {
  formState.traditions = value;
};
const selectClass = (value) => {
  formState.claseId = value.id;
};

const closeModal = () => {
  emit("onCancel");
}

const onCreation = async () => {
  try {
    await formRef.value.validate();
    const spellCreated = await createSpell(toRaw(formState), props.isFocus);
    if(spellCreated){
      message.success("Hechizo creado exitosamente");
      emit("onSubmit");
      closeModal();
    }
    else message.error("Fallo en Inserción de datos");
  } catch (error) {
    console.error("error on spell creation form:", error);
    return;
  }
};
</script>