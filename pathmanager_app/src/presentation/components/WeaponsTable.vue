<template>
  <a-modal v-model:open="isOpen" :footer="null" title="Agregar Arma">
    <WeaponCreateForm @onSubmit="reloadData" @onCancel="closeCreation"/>
  </a-modal>
  <CButton color="success" @click="openCreation">
    <FileAddOutlined />Añadir Arma
  </CButton>
  <a-table :data-source="data" :columns="columns">
    <template
      #customFilterDropdown="{
        setSelectedKeys,
        selectedKeys,
        confirm,
        clearFilters,
        column,
      }"
    >
      <SearchDropdown
        :setSelectedKeys="setSelectedKeys"
        :selectedKeys="selectedKeys"
        :confirm="confirm"
        :clearFilters="clearFilters"
        :column="column"
        @search="handleSearch"
        @reset="handleReset"
      />
    </template>
    <template #customFilterIcon="{ filtered }">
      <search-outlined :style="{ color: filtered ? '#108ee9' : undefined }" />
    </template>
    <template #bodyCell="{ text, column, record }">
      <span
        v-if="state.searchText && state.searchedColumn === column.dataIndex"
      >
        <template
          v-for="(fragment, i) in text
            .toString()
            .split(
              new RegExp(
                `(?<=${state.searchText})|(?=${state.searchText})`,
                'i'
              )
            )"
        >
          <mark
            v-if="fragment.toLowerCase() === state.searchText.toLowerCase()"
            :key="i"
            class="highlight"
          >
            {{ fragment }}
          </mark>
          <template v-else>{{ fragment }}</template>
        </template>
      </span>
      <template v-if="column.key === 'action'">
        <CButtonGroup vertical role="group">
          <a-tooltip placement="left" title="Detalles">
            <CButton color="info" size="sm" @click="openInfo(record.id)"><EyeOutlined /></CButton>
            <a-modal v-model:open="isInfoOpen[record.id]" :footer="null">
              <template #title>
                <GenericAction :name="record.nombre" :delay="1">
                  <template #content>
                    <strong>{{ 'Arma Nivel ' + record.nivel }}</strong>
                  </template>
                </GenericAction>
              </template>
              <WeaponDetails :weapon="record"/>
            </a-modal>
          </a-tooltip>
          <a-tooltip placement="left" title="Borrar">
            <CButton color="danger" size="sm"><DeleteOutlined /></CButton>
          </a-tooltip>
        </CButtonGroup>
      </template>
      <template v-else-if="column.key === 'traits'">
        <TraitAmountTag
            v-for="razgo in record.razgos"
            :id="razgo.id"
            :nombre="razgo.nombre"
            :descripcion="razgo.descripcion"
            :monto="razgo.monto"
        />
      </template>
      <template v-else-if="column.key === 'price'">
        <MoneyDisplay :money="record.precio"/>
      </template>
      <template v-else-if="column.key === 'weight'">
        <WeightDisplay :weight="record.peso"/>
      </template>
    </template>
  </a-table>
</template>
<script setup>
import { reactive, ref } from "vue";
import {
  SearchOutlined,
  EyeOutlined,
  DeleteOutlined,
  FileAddOutlined,
} from "@ant-design/icons-vue";
import { CButton, CButtonGroup } from "@coreui/vue";
import WeaponDetails from "./WeaponDetails.vue";
import GenericAction from './generic/GenericAction.vue';
import SearchDropdown from "./SearchDropdown.vue";
import TraitAmountTag from "./generic/TraitAmountTag.vue";
import WeaponCreateForm from "./WeaponCreateForm.vue";
import MoneyDisplay from "./generic/MoneyDisplay.vue";
import WeightDisplay from "./generic/WeightDisplay.vue";
import { getAllWeaponCategories } from "../../logic/WeaponCategoryOptions";
import { getAllWeaponGroups } from "../../logic/WeaponGroupOperations";
import { getAllWeaponTypes } from "../../logic/WeaponTypeOperations";
import { getAllTraits } from "../../logic/TraitOperations";
import { getAllDamageTypes } from "../../logic/DamageTypeOperations";
import { getAllWeaponsDisplay } from "../../logic/WeaponOperations";
import {damageTypesStorage, traitsStorage, weaponCategoriesStorage, weaponGroupsStorage, weaponTypesStorage} from "../../logic/Storage";

const data = ref([]);
const isInfoOpen = ref({});
const isOpen = ref(false);

try {
  //se cargan al storage varias listas de valores simples {id, nombre}
  if (traitsStorage.isEmpty()) traitsStorage.fillData(await getAllTraits());
  if (damageTypesStorage.isEmpty()) damageTypesStorage.fillData(await getAllDamageTypes());
  if (weaponCategoriesStorage.isEmpty()) weaponCategoriesStorage.fillData(await getAllWeaponCategories());
  if (weaponGroupsStorage.isEmpty()) weaponGroupsStorage.fillData(await getAllWeaponGroups());
  if (weaponTypesStorage.isEmpty()) weaponTypesStorage.fillData(await getAllWeaponTypes());
  //se cargan todas las armas
  data.value = await getAllWeaponsDisplay();
  data.value.forEach((element) => {
      isInfoOpen.value[element.id] = false;
    });
    console.log("fetched weapons:", data.value);
} catch (error) {
  console.error("error on weapons table", error);
}

const state = reactive({
  searchText: "",
  searchedColumn: "",
});
const searchInput = ref();
const columns = [
  {
    title: "Nombre",
    dataIndex: "nombre",
    key: "name",
    customFilterDropdown: true,
    sorter: (a, b) => a.nombre.localeCompare(b.nombre),
    onFilter: (value, record) =>
      record.nombre.toString().toLowerCase().includes(value.toLowerCase()),
    onFilterDropdownOpenChange: (visible) => {
      if (visible) {
        setTimeout(() => {
          searchInput.value.focus();
        }, 100);
      }
    },
  },
  {
    title: "Nivel",
    dataIndex: "nivel",
    key: "level",
    sorter: (a, b) => a.nivel - b.nivel,
  },
  {
    title: "Precio",
    dataIndex: "precio",
    key: "price",
  },
  {
    title: "Peso",
    dataIndex: "peso",
    key: "weight",
    sorter: (a, b) => a.peso - b.peso,
  },
  {
    title: "Tipo",
    dataIndex: "tipo",
    key: "type",
    filters: weaponTypesStorage.dataFilter,
    sorter: (a, b) => a.tipo.localeCompare(b.tipo),
    onFilter: (value, record) =>
      record.type.toString().toLowerCase().includes(value.toLowerCase()),
  },
  {
    title: "Grupo",
    dataIndex: "grupo",
    key: "group",
    filters: weaponGroupsStorage.dataFilter,
    sorter: (a, b) => a.grupo.localeCompare(b.grupo),
    onFilter: (value, record) =>
      record.grupo.toString().toLowerCase().includes(value.toLowerCase()),
  },
  {
    title: "Razgos",
    dataIndex: "razgos",
    key: "traits",
  },
  {
    title: "Operaciones",
    key: "action",
  },
];
const handleSearch = (selectedKeys, confirm, dataIndex) => {
  confirm();
  state.searchText = selectedKeys[0];
  state.searchedColumn = dataIndex;
};
const handleReset = (clearFilters) => {
  clearFilters({
    confirm: true,
  });
  state.searchText = "";
};
const openInfo = (weaponId) => {
  isInfoOpen.value[weaponId] = true;
}
const openCreation = () => {
  isOpen.value = true;
};
const closeCreation = () => {
  isOpen.value = false;
};
const reloadData = async () => {
  try {
    const response = await getAllWeaponsDisplay();
    data.value = response;
    data.value.forEach((element) => {
      isInfoOpen.value[element.id] = false;
    });
  } catch (error) {
    console.error("error on weapons table", error);
  }
};
</script>
<style scoped>
.highlight {
  background-color: rgb(255, 192, 105);
  padding: 0px;
}
</style>