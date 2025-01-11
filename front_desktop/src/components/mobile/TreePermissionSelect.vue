<template>
  <el-tree-select
    v-model="ids"
    :data="treePermission"
    :props="{ label: 'name' }"
    node-key="id"
    :render-after-expand="false"
    check-strictly
    :multiple="multiple"
    :placeholder="placeholder"
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
  },
  placeholder: {
    type: String,
    default: ""
  }
});
const emits = defineEmits(["update:modelValue"]);
const treePermission = ref([]);
const ids = ref(props.modelValue);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.mobile.treePermissionSelect/getTreePermission"
  );
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  treePermission.value = response.data;
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
