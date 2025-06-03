<template>
  <a-modal v-model:open="isOpen" :footer="null" title="Agregar Hechizo">
    <SpellCreateForm @onSubmit="reloadData" @onCancel="closeCreation" />
  </a-modal>
  <CButton color="success" @click="openCreation"
    ><FileAddOutlined />Añadir Hechizo</CButton
  >
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
                <GenericAction :name="record.nombre" :delay="record.demora">
                  <template #content>
                    <strong>{{ '   ' + record.nivel }}</strong>
                  </template>
                </GenericAction>
              </template>
              <SpellDetails :spell="record"/>
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
      <template v-else-if="column.key === 'traditions'">
        <span>
          <a-tag
            v-for="tradicion in record.tradiciones"
            :key="tradicion.nombre"
            :color="
              tradicion.nombre === 'arcano'
                ? 'geekblue'
                : tradicion.nombre === 'divino'
                ? 'gold'
                : tradicion.nombre === 'oculto'
                ? 'purple'
                : 'lime'
            "
          >
            {{ tradicion.nombre.toUpperCase() }}
          </a-tag>
        </span>
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
import SpellDetails from './SpellDetails.vue';
import GenericAction from './generic/GenericAction.vue';
import SearchDropdown from "./SearchDropdown.vue";
import TraitTag from "./generic/TraitTag.vue";
import SpellCreateForm from "./SpellCreateForm.vue";
import { getAllSpells } from "../../logic/SpellOperations";
import { getAllClasses } from "../../logic/ClassOperations";
import { getAllTraditions } from "../../logic/TraditionOperations";
import { getAllTargets } from "../../logic/TargetOperations";
import { getAllSchools } from "../../logic/SchoolOperations";
import { getAllTraits } from "../../logic/TraitOperations";
import {
  classesStorage,
  spellTargetsStorage,
  spellTraditionsStorage,
  spellSchoolsStorage,
  traitsStorage
} from "../../logic/Storage";

const data = ref([]);
const isInfoOpen = ref({});
const isOpen = ref(false);

try {
  const response = await getAllSpells();
  data.value = response;
  data.value.forEach((element) => {
    isInfoOpen.value[element.id] = false;
  });
  console.log("fetched spells", response);
  //se cargan al storage varias listas de valores simples {id, nombre}
  if (classesStorage.isEmpty()) classesStorage.fillData(await getAllClasses());
  if (spellTargetsStorage.isEmpty())
    spellTargetsStorage.fillData(await getAllTargets());
  if (spellTraditionsStorage.isEmpty())
    spellTraditionsStorage.fillData(await getAllTraditions());
  if (spellSchoolsStorage.isEmpty())
    spellSchoolsStorage.fillData(await getAllSchools());
  if (traitsStorage.isEmpty()) traitsStorage.fillData(await getAllTraits());
} catch (error) {
  console.error("error on spells table", error);
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
    title: "Efecto",
    dataIndex: "efecto",
    key: "effect",
  },
  {
    title: "Aumentos",
    dataIndex: "aumentos",
    key: "heigthened",
  },
  {
    title: "Blancos",
    dataIndex: "blancos",
    key: "targets",
    filters: spellTargetsStorage.dataFilter,
    onFilter: (value, record) =>
      record.blancos.toString().toLowerCase().includes(value.toLowerCase()),
  },
  {
    title: "Escuela",
    dataIndex: "escuela",
    key: "school",
    filters: spellSchoolsStorage.dataFilter,
    sorter: (a, b) => a.escuela.localeCompare(b.escuela),
    onFilter: (value, record) =>
      record.escuela.toString().toLowerCase().includes(value.toLowerCase()),
  },
  {
    title: "Tradiciones",
    dataIndex: "tradiciones",
    key: "traditions",
    filters: spellTraditionsStorage.dataFilter,
    onFilter: (value, record) => {
      for (let i = 0; i < record.tradiciones.length; i++) {
        const tradition = record.tradiciones[i].nombre;
        if (tradition.toLowerCase().includes(value.toLowerCase())) return true;
      }
      return false;
    },
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
const openInfo = (spellId) => {
  isInfoOpen.value[spellId] = true;
}
const openCreation = () => {
  isOpen.value = true;
};
const closeCreation = () => {
  isOpen.value = false;
};
const reloadData = async () => {
  try {
    const response = await getAllSpells();
    data.value = response;
    data.value.forEach((element) => {
      isInfoOpen.value[element.id] = false;
    });
    console.log("reloaded spells", response);
  } catch (error) {
    console.error("error on spells table", error);
  }
};
</script>
<style scoped>
.highlight {
  background-color: rgb(255, 192, 105);
  padding: 0px;
}
</style>
