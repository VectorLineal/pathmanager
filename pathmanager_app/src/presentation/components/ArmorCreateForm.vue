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
      <a-col :sm="5" :md="4" :lg="3" :xl="2">
        <a-form-item label="Nivel" name="nivel">
          <a-input-number v-model:value="formState.nivel" :min="0" :max="30" />
        </a-form-item>
      </a-col>
      <a-col :sm="5" :md="4" :lg="3" :xl="2">
        <a-form-item label="Armadura" name="ac">
          <a-input-number v-model:value="formState.ac" :min="0" :max="20"/>
        </a-form-item>
      </a-col>
      <a-col :sm="6" :md="5" :lg="4" :xl="3">
        <a-form-item label="Límite de Destreza" name="limite">
          <a-input-number v-model:value="formState.limite" :min="0" :max="6"/>
        </a-form-item>
      </a-col>
      <a-col :sm="5" :md="4" :lg="3" :xl="2">
        <a-form-item label="Precio" name="precio">
          <a-input-number v-model:value="formState.precio" :min="0"/>
        </a-form-item>
      </a-col>
      <a-col :sm="5" :md="4" :lg="3" :xl="2">
        <a-form-item label="Peso" name="peso">
          <a-input-number v-model:value="formState.peso" :min="0" :max="20" :step="0.1"/>
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Penalización de dados" name="penalizacion">
          <a-input-number v-model:value="formState.penalizacion" :min="-3" :max="0" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Penalización de Velocidad" name="velocidad">
          <a-input-number v-model:value="formState.velocidad" :min="-10" :max="0" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Requisito de Fuerza" name="requisito">
          <a-input-number v-model:value="formState.requisito" :min="0" :max="5" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Fortaleza" name="fortaleza">
          <a-input-number v-model:value="formState.fortaleza" :min="0" :max="5" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Reflejos" name="reflejos">
          <a-input-number v-model:value="formState.reflejos" :min="0" :max="5" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Voluntad" name="voluntad">
          <a-input-number v-model:value="formState.voluntad" :min="0" :max="5" />
        </a-form-item>
      </a-col>
      <a-col :sm="6" :md="5" :lg="4" :xl="3">
        <a-form-item label="Categoría" name="categoriaId">
          <WeaponCategorySelector @onSelect="selectCategory" />
        </a-form-item>
      </a-col>
      <a-col :sm="7" :md="6" :lg="5" :xl="4">
        <a-form-item label="Grupo" name="grupoId">
          <WeaponGroupSelector @onSelect="selectGroup" />
        </a-form-item>
      </a-col>
      <a-col :sm="12" :md="9" :lg="8" :xl="7">
        <a-form-item label="Razgos" name="traits">
          <TraitsSelector @onSelect="selectTraits" />
        </a-form-item>
      </a-col>
      <a-col :xs="24" :sm="24" :lg="12">
        <a-form-item label="Efecto Especial" name="efecto">
          <a-textarea v-model:value="formState.efecto" />
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
import Armor from "../../data/models/Armor";
import { createArmor } from "../../logic/ArmorOperations";
import WeaponCategorySelector from "./selectors/WeaponCategorySelector.vue";
import WeaponGroupSelector from "./selectors/WeaponGroupSelector.vue";
import TraitsSelector from "./selectors/TraitsSelector.vue";

const emit = defineEmits(["onSubmit", "onCancel"]);

const formState = reactive(new Armor());
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
  grupoId: [
    {
      required: true,
      message: "Seleccione un grupo de arma",
      trigger: "change",
    },
  ],
  categoriaId: [
    {
      required: true,
      message: "Seleccione una categoría de arma",
      trigger: "change",
    },
  ],
  nombre: [
    {
      whitespace: true,
      required: true,
      message: "Escriba un nombre",
      trigger: "change",
    },
  ],
  ac: [
    {
      required: true,
      message: "Escriba un monto de armadura",
      trigger: "change",
    },
  ]
};

const selectCategory = (value) => {
  formState.categoriaId = value;
};
const selectTraits = (value) => {
  formState.traits = value;
};
const selectGroup = (value) => {
  formState.grupoId = value;
};

const closeModal = () => {
  emit("onCancel");
}

const onCreation = async () => {
  try {
    await formRef.value.validate();
    const createdWeapon = await createArmor(toRaw(formState));
    if(createdWeapon){
      message.success("Arma creada exitosamente");
      emit("onSubmit");
      closeModal();
    }
    else message.error("Fallo en Inserción de datos");
  } catch (error) {
    console.error("error on weapon creation form:", error);
    return;
  }
};
</script>