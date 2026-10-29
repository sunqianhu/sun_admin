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
    :empty-values="[0, '', undefined]"
    clearable
  />
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  permissionId: {
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
const ids = defineModel({
  type: [Number, Array],
});
const treePermission = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.TreePermissionSelect/getTreePermission",
    {
      params: {
        permission_id: props.permissionId,
      },
    },
  );
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  treePermission.value = response.data;
};

watch(() => props.permissionId, () => {
  init();
});

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
