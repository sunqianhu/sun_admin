<template>
  <el-tree-select
    v-model="ids"
    :data="treeDepartmentUser"
    :props="{ label: 'name', isLeaf: 'is_leaf' }"
    node-key="id"
    :render-after-expand="true"
    check-strictly
    :multiple="multiple"
    lazy
    :load="loadNode"
    :placeholder="placeholder"
    :empty-values="[0, '', undefined]"
    clearable
    @node-click="handleNodeClick"
  />
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  modelValue: {
    type: [Number, String, Array],
    default: "",
  },
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
});
const emits = defineEmits(["update:modelValue"]);
const treeDepartmentUser = ref([]);
const ids = ref(props.modelValue);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.treeUserSelect/getDepartmentsUsers",
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
  treeDepartmentUser.value = response.data;
};

/**
 * 加载节点
 * @param node
 * @param resolve
 */
const loadNode = async (node, resolve) => {
  if (node.level == 0) {
    resolve([]);
    return;
  }
  if (node.data.type == "user") {
    resolve([]);
    return;
  }

  const departmentId = node.data.id.replace("department_", "");
  const response = await axios.get(
    "desktop/components.treeUserSelect/getDepartmentsUsers",
    {
      params: {
        department_id: departmentId,
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

  resolve(response.data);
};

/**
 * 点击节点时的处理
 */
const handleNodeClick = (nodeData, node) => {
  if (nodeData.type == "department") {
    alert("点击了部门");
    return;
  }
};

watch(
  () => props.modelValue,
  (newValue) => {
    ids.value = newValue;
  },
  {
    deep: true,
  }
);
watch(
  () => props.departmentId,
  (newValue) => {
    init();
  },
  {
    deep: true,
  }
);
watch(
  () => ids.value,
  (newValue) => {
    emits("update:modelValue", newValue);
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
