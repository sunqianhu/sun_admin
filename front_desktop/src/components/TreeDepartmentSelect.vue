<template>
  <el-tree-select
    v-model="ids"
    :data="treeDepartment"
    :props="{ label: 'name' }"
    node-key="id"
    :render-after-expand="false"
    check-strictly
    :multiple="multiple"
    clearable
  />
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  modelValue: {
    type: [Number, String, Array],
    default: ""
  },
  multiple: {
    type: Boolean,
    default: false
  }
});
const emits = defineEmits(["update:modelValue"]);
const treeDepartment = ref([]);
const ids = ref(props.modelValue);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/components.TreeDepartmentSelect/getTreeDepartment");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  treeDepartment.value = response.data;
};

watch(
  () => props.modelValue,
  (newValue) => {
    ids.value = newValue;
  },
  {
    deep: true
  }
);
watch(
  () => ids.value,
  (newValue) => {
    emits("update:modelValue", newValue);
  },
  {
    deep: true
  }
);

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
