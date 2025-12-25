<template>
  <el-select
    v-model="ids"
    filterable
    clearable
    :multiple="multiple"
    :empty-values="[0, '', undefined]"
  >
    <el-option v-for="role in roles" :label="role.name" :value="role.id" />
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
  type: [Number, Array],
});
const roles = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/components.roleSelect/getRoles");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  roles.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
