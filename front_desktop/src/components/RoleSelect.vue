<template>
  <el-select v-model="ids" filterable clearable :multiple="multiple">
    <el-option v-for="role in roles" :label="role.name" :value="role.id" />
  </el-select>
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
const roles = ref([]);
const ids = ref(props.modelValue);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/components.roleSelect/getRoles");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  roles.value = response.data;
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
