<template>
  <div style="padding: 8px">
    <a-input
      ref="searchInput"
      :placeholder="`Search ${column.dataIndex}`"
      :value="selectedKeys[0]"
      style="width: 188px; margin-bottom: 8px; display: block"
      @change="(e) => setSelectedKeys(e.target.value ? [e.target.value] : [])"
      @pressEnter="handleSearch(selectedKeys, confirm, column.dataIndex)"
    />
    <a-button type="primary" size="small" style="width: 90px; margin-right: 8px"
      @click="handleSearch(selectedKeys, confirm, column.dataIndex)">
      <template #icon><SearchOutlined /></template>
      Search
    </a-button>
    <a-button size="small" style="width: 90px" @click="handleReset(clearFilters)">
      Reset
    </a-button>
  </div>
</template>
<script setup>
import { ref } from 'vue';
import {SearchOutlined} from '@ant-design/icons-vue';

const props = defineProps({
  setSelectedKeys: Function,
  selectedKeys: Array,
  confirm: Function,
  clearFilters: Function,
  column: Object
});

const emit = defineEmits(["search", "reset"]);

const handleReset = (filters) => {
  emit("reset", filters);
};

const handleSearch = (selectedKeys, confirm, dataIndex) => {
  emit("search", selectedKeys, confirm, dataIndex);
};
</script>
