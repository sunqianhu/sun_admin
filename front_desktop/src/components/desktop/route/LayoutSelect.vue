<template>
  <el-select v-model="ids" filterable clearable :multiple="multiple">
    <el-option
      v-for="layout in layouts"
      :label="layout.value"
      :value="parseInt(layout.key)"
    />
  </el-select>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  modelValue: {
    type: [Number, String],
    default: "",
  },
  multiple: {
    type: Boolean,
    default: false,
  },
});
const emits = defineEmits(["update:modelValue"]);
const layouts = ref([]);
const ids = ref(props.modelValue);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.desktop.route.LayoutSelect/getLayouts"
  );
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  layouts.value = response.data;
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
