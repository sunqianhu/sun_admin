<template>
  <div class="users-selector">
    <span class="selected-user" v-if="userIds.length > 0">
      已选 <strong>{{ userIds.length }}</strong> 用户
    </span>
    <el-button @click="openUsersSelectorDialog">选择</el-button>
    <users-selector-dialog
      v-model="userIds"
      @close="closeUsersSelectorDialog"
      @confirmed="closeUsersSelectorDialog"
      v-if="usersSelectorDialogFlag"
    ></users-selector-dialog>
  </div>
</template>

<script setup>
import { ref, watch } from "vue";
import UsersSelectorDialog from "./UsersSelectorDialog.vue";

const props = defineProps({
  modelValue: {
    type: Array,
    default: [],
  },
});
const emits = defineEmits(["update:modelValue"]);
const userIds = ref([...props.modelValue]);
const usersSelectorDialogFlag = ref(false);

/**
 * 打开选择用户对话框
 */
const openUsersSelectorDialog = () => {
  usersSelectorDialogFlag.value = true;
};

/**
 * 关闭选择用户对话框
 */
const closeUsersSelectorDialog = () => {
  usersSelectorDialogFlag.value = false;
};

watch(
  () => props.modelValue,
  async (newValue) => {
    userIds.value = newValue;
  },
  {
    deep: true,
  }
);
watch(
  () => userIds.value,
  (newValue) => {
    emits("update:modelValue", newValue);
  },
  {
    deep: true,
  }
);
</script>

<style lang="scss" scoped>
.users-selector {
  .selected-user {
    margin-right: var(--margin-sm);
    strong {
      color: var(--color-primary);
    }
  }
}
</style>
