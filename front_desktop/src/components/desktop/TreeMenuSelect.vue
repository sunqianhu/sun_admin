<template>
  <el-tree-select
    v-model="ids"
    :data="treeMenu"
    :props="{ label: 'name' }"
    node-key="id"
    :render-after-expand="false"
    check-strictly
    :multiple="multiple"
    :placeholder="placeholder"
    :empty-values="[0, '', undefined]"
    clearable
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
  menuId: {
    type: Number,
    default: 0,
  },
  multiple: {
    type: Boolean,
    default: false,
  },
  placeholder: {
    type: String,
    default: "",
  },
});
const emits = defineEmits(["update:modelValue"]);
const treeMenu = ref([]);
const ids = ref(props.modelValue);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.desktop.treeMenuSelect/getTreeMenu",
    {
      params: { menu_id: props.menuId },
    }
  );
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  treeMenu.value = response.data;
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
