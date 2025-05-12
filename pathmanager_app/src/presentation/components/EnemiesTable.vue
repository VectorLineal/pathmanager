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
    <template #bodyCell="{ text, column, record }">
      <span v-if="state.searchText && state.searchedColumn === column.dataIndex">
        <template v-for="(fragment, i) in text.toString().split(new RegExp(`(?<=${state.searchText})|(?=${state.searchText})`,'i'))">
          <mark v-if="fragment.toLowerCase() === state.searchText.toLowerCase()" :key="i" class="highlight">
            {{ fragment }}
          </mark>
          <template v-else>{{ fragment }}</template>
        </template>
      </span>
      <template v-if="column.key === 'action'">
        <CButtonGroup vertical role="group">
          <a-tooltip placement="left" title="Detalles">
            <RouterLink :to="'/enemigo/' + text.id">
              <CButton color="info" size="sm"><EyeOutlined/></CButton>
            </RouterLink >
          </a-tooltip>
          <a-tooltip placement="left" title="Borrar">
            <RouterLink :to="'/enemigo/' + text.id">
              <CButton color="danger" size="sm"><DeleteOutlined/></CButton>
            </RouterLink>
          </a-tooltip>
        </CButtonGroup>
      </template>
      <template v-else-if="column.key === 'traits'">
        <TraitTag v-for="razgo in record.razgos" :id="razgo.id" :name="razgo.nombre" :description="razgo.descripcion" />
      </template>
    </template>
  </a-table>
</template>
<script setup>
import { reactive, ref } from "vue";
import { SearchOutlined, EyeOutlined, FormOutlined, DeleteOutlined } from "@ant-design/icons-vue";
import { CButton, CButtonGroup } from "@coreui/vue";
import { RouterLink } from "vue-router";
import SearchDropdown from "./SearchDropdown.vue";
import TraitTag from "./generic/TraitTag.vue";
import { getAllEntities } from "../../logic/EntityOperations";
import { getAllAlignments } from "../../logic/AlignmentOperations";
import { getAllClasses } from "../../logic/ClassOperations";
import { getAllRaces } from "../../logic/RaceOperations";
import { getAllSizes } from "../../logic/SizeOperations";
import { alignmentsStorage, sizesStorage, racesStorage, classesStorage } from "../../logic/Storage";
const data = ref([]);

try{
  const response = await getAllEntities();
  data.value = response;
  console.log("fetched entities", response);
  //se cargan al storage varias listas de valores simples {id, nombre}
  if(alignmentsStorage.isEmpty()) alignmentsStorage.fillData(await getAllAlignments());
  if(sizesStorage.isEmpty()) sizesStorage.fillData(await getAllSizes());
  if(racesStorage.isEmpty()) racesStorage.fillData(await getAllRaces());
  if(classesStorage.isEmpty()) classesStorage.fillData(await getAllClasses());
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
    filters: alignmentsStorage.dataFilter,
    sorter: (a, b) => a.alineacion.localeCompare(b.alineacion),
    onFilter: (value, record) =>
      record.alineacion.toString().toLowerCase().includes(value.toLowerCase()),
  },
  {
    title: "Tamaño",
    dataIndex: "tamano",
    key: "size",
    filters: sizesStorage.dataFilter,
    sorter: (a, b) => a.tamano.localeCompare(b.tamano),
    onFilter: (value, record) =>
      record.tamano.toString().toLowerCase().includes(value.toLowerCase()),
    
  },
  {
    title: "Raza",
    dataIndex: "raza",
    key: "race",
    filters: racesStorage.dataFilter,
    sorter: (a, b) => a.raza.localeCompare(b.raza),
    onFilter: (value, record) =>
      record.raza.toString().toLowerCase().includes(value.toLowerCase()),
  },
  {
    title: "Clase",
    dataIndex: "clase",
    key: "class",
    filters: classesStorage.dataFilter,
    sorter: (a, b) => a.clase.localeCompare(b.clase),
    onFilter: (value, record) =>
      record.clase.toString().toLowerCase().includes(value.toLowerCase()),
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
</script>
<style scoped>
.highlight {
  background-color: rgb(255, 192, 105);
  padding: 0px;
}
</style>
