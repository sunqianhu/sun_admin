<template>
  <el-select
    v-model="ids"
    filterable
    clearable
    :multiple="multiple"
    :empty-values="[0, '', undefined]"
  >
    <el-option
      v-for="layout in layouts"
      :label="layout.value"
      :value="layout.key"
    />
  </el-select>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  multiple: {
    type: Boolean,
    default: false,
  },
});
const ids = defineModel({
  type: [Number, String, Array],
});
const layouts = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.desktop.route.LayoutSelect/getLayouts",
  );
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  layouts.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
