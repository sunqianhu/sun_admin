<template>
  <el-select
    v-model="ids"
    filterable
    clearable
    :empty-values="['', 0, undefined]"
    :multiple="multiple"
    @change="change"
  >
    <el-option v-for="user in users" :label="user.name" :value="user.id" />
  </el-select>
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
});
const emits = defineEmits(["update:modelValue", "change"]);
const users = ref([]);
const ids = ref(props.modelValue);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.DepartmentUsersSelect/getUsers",
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
  users.value = response.data;
};

/**
 * 改变值
 * @param value
 */
const change = (value) => {
  emits("change", value);
};

watch(
  () => props.modelValue,
  async (newValue) => {
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
