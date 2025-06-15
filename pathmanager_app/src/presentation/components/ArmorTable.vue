<template>
  <a-modal v-model:open="isOpen" :footer="null" title="Agregar Armadura" style="width: 83%;">
    <ArmorCreateForm @onSubmit="reloadData" @onCancel="closeCreation"/>
  </a-modal>
  <CButton color="success" @click="openCreation">
    <FileAddOutlined />Añadir Armadura
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
                <strong>{{ record.nombre +': Armadura Nivel ' + record.nivel }}</strong>
              </template>
              <ArmorDetails :armor="record"/>
            </a-modal>
          </a-tooltip>
          <a-tooltip placement="left" title="Borrar">
            <CButton color="danger" size="sm"><DeleteOutlined /></CButton>
          </a-tooltip>
        </CButtonGroup>
      </template>
      <template v-else-if="column.key === 'traits'">
        <TraitTag
            v-for="razgo in record.razgos"
            :id="razgo.id"
            :name="razgo.nombre"
            :description="razgo.descripcion"
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
import ArmorDetails from "./ArmorDetails.vue";
import ArmorCreateForm from "./ArmorCreateForm.vue";
import TraitTag from "./generic/TraitTag.vue";
import SearchDropdown from "./generic/SearchDropdown.vue";
import MoneyDisplay from "./generic/MoneyDisplay.vue";
import WeightDisplay from "./generic/WeightDisplay.vue";
import { getAllWeaponCategories } from "../../logic/WeaponCategoryOptions";
import { getAllWeaponGroups } from "../../logic/WeaponGroupOperations";
import { getAllTraits } from "../../logic/TraitOperations";
import { getAllArmorsDisplay } from "../../logic/ArmorOperations";
import { traitsStorage, weaponCategoriesStorage, weaponGroupsStorage} from "../../logic/Storage";

const data = ref([]);
const isInfoOpen = ref({});
const isOpen = ref(false);

try {
  //se cargan al storage varias listas de valores simples {id, nombre}
  if (traitsStorage.isEmpty()) traitsStorage.fillData(await getAllTraits());
  if (weaponCategoriesStorage.isEmpty()) weaponCategoriesStorage.fillData(await getAllWeaponCategories());
  if (weaponGroupsStorage.isEmpty()) weaponGroupsStorage.fillData(await getAllWeaponGroups());;
  //se cargan todas las armas
  data.value = await getAllArmorsDisplay();
  data.value.forEach((element) => {
      isInfoOpen.value[element.id] = false;
    });
    console.log("fetched armors:", data.value);
} catch (error) {
  console.error("error on armors table", error);
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
    title: "AC",
    dataIndex: "ac",
    key: "ac",
    sorter: (a, b) => a.ac - b.ac,
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
    const response = await getAllArmorsDisplay();
    data.value = response;
    data.value.forEach((element) => {
      isInfoOpen.value[element.id] = false;
    });
  } catch (error) {
    console.error("error on armors table", error);
  }
};
</script>
<style scoped>
.highlight {
  background-color: rgb(255, 192, 105);
  padding: 0px;
}
</style>