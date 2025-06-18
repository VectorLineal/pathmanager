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
        <a-form-item label="Precio" name="precio">
          <a-input-number v-model:value="formState.precio" :min="0"/>
        </a-form-item>
      </a-col>
      <a-col :sm="5" :md="4" :lg="3" :xl="2">
        <a-form-item label="Peso" name="peso">
          <a-input-number v-model:value="formState.peso" :min="0" :max="20" :step="0.1"/>
        </a-form-item>
      </a-col>
      <a-col :sm="6" :md="5" :lg="4" :xl="3">
        <a-form-item label="Tipo de Item" name="tipoId">
          <ItemTypeSelector @onSelect="selectType" />
        </a-form-item>
      </a-col>
      <a-col :sm="12" :md="9" :lg="8" :xl="7">
        <a-form-item label="Razgos" name="traits">
          <TraitsSelector @onSelect="selectTraits" />
        </a-form-item>
      </a-col>
      <a-col :sm="12" :md="9" :lg="8" :xl="7" v-if="maySelectAttributes">
        <a-form-item label="Atributos" name="attributes">
          <AttributesSelector @updatedValues="selectAttributes" />
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
import { reactive, ref, toRaw, computed } from "vue";
import { CButton, CButtonGroup, CButtonToolbar } from "@coreui/vue";
import { message } from "ant-design-vue";
import MiscItem from "../../data/models/MiscItem";
import { createMiscItem } from "../../logic/MiscItemOperations";
import ItemTypeSelector from "./selectors/ItemTypeSelector.vue";
import TraitsSelector from "./selectors/TraitsSelector.vue";
import AttributesSelector from "./selectors/AttributesSelector.vue";

const emit = defineEmits(["onSubmit", "onCancel"]);

const formState = reactive(new MiscItem());
const formRef = ref();
const labelCol = {
  span: 24,
};
const wrapperCol = {
  span: 24,
};

const maySelectAttributes = computed(() => {
    return (formState.tipoId >= 4 && formState.tipoId <= 9) || (formState.tipoId >= 12 && formState.tipoId <= 14);
});

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
  tipoId: [
    {
      required: true,
      message: "Seleccione un tipo de ítem",
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
  ]
};

const selectType = (value) => {
  formState.tipoId = value;
};
const selectTraits = (value) => {
  formState.traits = value;
};
const selectAttributes = (value) => {
  formState.attributes = value;
};

const closeModal = () => {
  emit("onCancel");
}

const onCreation = async () => {
  try {
    await formRef.value.validate();
    const createdWeapon = await createMiscItem(toRaw(formState));
    if(createdWeapon){
      message.success("Item Miscelaneo creada exitosamente");
      emit("onSubmit");
      closeModal();
    }
    else message.error("Fallo en Inserción de datos");
  } catch (error) {
    console.error("error on miscItem creation form:", error);
    return;
  }
};
</script>