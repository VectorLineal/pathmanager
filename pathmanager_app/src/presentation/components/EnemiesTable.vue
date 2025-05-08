<template>
  <a-table :data-source="data" :columns="columns">
    <template #headerCell="{ column }">
      <template v-if="column.key === 'name'">
        <span style="color: #1890ff">Name</span>
      </template>
    </template>
    <template
      #customFilterDropdown="{setSelectedKeys, selectedKeys, confirm, clearFilters, column}"
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
    <template #bodyCell="{ text, column }">
      <span v-if="state.searchText && state.searchedColumn === column.dataIndex">
        <template v-for="(fragment, i) in text.toString().split(new RegExp(`(?<=${state.searchText})|(?=${state.searchText})`,'i'))">
          <mark v-if="fragment.toLowerCase() === state.searchText.toLowerCase()" :key="i" class="highlight">
            {{ fragment }}
          </mark>
          <template v-else>{{ fragment }}</template>
        </template>
      </span>
      <template v-if="column.key === 'action'">
        <span>
          <a>Detalles</a>
          <a-divider type="vertical" />
          <a>Editar</a>
          <a-divider type="vertical" />
          <a>Borrar</a>
        </span>
      </template>
    </template>
  </a-table>
</template>
<script setup>
import { reactive, ref } from "vue";
import { SearchOutlined } from "@ant-design/icons-vue";
import SearchDropdown from "./SearchDropdown.vue";
import { getAllEntities } from "../../logic/EntityOperations";
const data = ref([]);

try{
  const response = await getAllEntities();
  data.value = response;
  console.log("fetched entities", response);
}catch(error){
  console.error("error on enemies table", error);
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
    title: "Experiencia",
    dataIndex: "experiencia",
    key: "xp",
    sorter: (a, b) => a.experiencia - b.experiencia,
  },
  {
    title: "Salud",
    dataIndex: "salud",
    key: "health",
    sorter: (a, b) => a.salud - b.salud,
  },
  {
    title: "AC",
    dataIndex: "AC",
    key: "AC",
    sorter: (a, b) => a.AC - b.AC,
  },
  {
    title: "Iniciativa",
    dataIndex: "iniciativa",
    key: "init",
  },
  {
    title: "Percepción",
    dataIndex: "percepcion",
    key: "per",
  },
  {
    title: "Alineación",
    dataIndex: "alineacion",
    key: "alignment",
    filters: [
      {
        text: "Neutral Malvado",
        value: "neutral malvado",
      },
      {
        text: "Legal Malvado",
        value: "legal malvado",
      },
      {
        text: "Caótico Malvado",
        value: "caótico malvado",
      },
    ],
    sorter: (a, b) => a.alineacion.localeCompare(b.alineacion),
    onFilter: (value, record) =>
      record.alineacion.toString().toLowerCase().includes(value.toLowerCase()),
  },
  {
    title: "Tamaño",
    dataIndex: "tamano",
    key: "size",
    sorter: (a, b) => a.tamano.localeCompare(b.tamano),
  },
  {
    title: "Raza",
    dataIndex: "raza",
    key: "race",
    filters: [
      {
        text: "No-muerto",
        value: "no-muerto",
      },
      {
        text: "Enano",
        value: "enano",
      },
    ],
    sorter: (a, b) => a.raza.localeCompare(b.raza),
    onFilter: (value, record) =>
      record.raza.toString().toLowerCase().includes(value.toLowerCase()),
  },
  {
    title: "Clase",
    dataIndex: "clase",
    key: "class",
    sorter: (a, b) => a.clase.localeCompare(b.clase),
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
</script>
<style scoped>
.highlight {
  background-color: rgb(255, 192, 105);
  padding: 0px;
}
</style>
