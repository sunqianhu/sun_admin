<template>
  <el-select
    v-model="ids"
    filterable
    clearable
    :empty-values="['', 0, undefined]"
    :multiple="multiple"
    collapse-tags
    collapse-tags-tooltip
    :max-collapse-tags="maxCollapseTags"
    @change="change"
  >
    <el-option v-for="user in users" :label="user.name" :value="user.id" />
  </el-select>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  departmentId: {
    type: Number,
    required: true,
  },
  multiple: {
    type: Boolean,
    default: false,
  },
  maxCollapseTags: {
    type: Number,
    default: 1,
  },
});
const ids = defineModel({
  type: [Number, Array],
});
const emits = defineEmits(["change"]);
const users = ref([]);

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
