<template>
  <el-tree-select
    v-model="ids"
    :data="treeDepartment"
    :props="{ label: 'name' }"
    node-key="id"
    check-strictly
    :multiple="true"
    :empty-values="[0, '', undefined]"
    collapse-tags
    collapse-tags-tooltip
    :max-collapse-tags="2"
    clearable
    filterable
  />
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";

const treeDepartment = ref([]);
const ids = defineModel({
  type: Array,
});

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/system.data_scope.policy.TreeDepartmentSelect/getTreeDepartment",
  );
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  treeDepartment.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
