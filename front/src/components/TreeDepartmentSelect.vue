<template>
  <el-tree-select
    v-model="ids"
    :data="treeDepartment"
    :props="{ label: 'name' }"
    node-key="id"
    :render-after-expand="false"
    check-strictly
    :multiple="multiple"
    :placeholder="placeholder"
    :empty-values="[0, '', undefined]"
    collapse-tags
    collapse-tags-tooltip
    :max-collapse-tags="maxCollapseTags"
    clearable
    filterable
  />
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  departmentId: {
    type: Number,
    default: 0,
  },
  multiple: {
    type: Boolean,
    default: false,
  },
  placeholder: {
    type: String,
    default: undefined,
  },
  maxCollapseTags: {
    type: Number,
    default: 1,
  },
});
const ids = defineModel({
  type: [Number, Array],
});
const treeDepartment = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.TreeDepartmentSelect/getTreeDepartment",
    {
      params: {
        department_id: props.departmentId,
      },
    }
  );
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  treeDepartment.value = response.data;
};

watch(
  () => props.departmentId,
  (newValue) => {
    init();
  },
  {
    deep: true,
  }
);

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
