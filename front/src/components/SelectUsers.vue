<template>
  <div class="select-users">
    <span class="selected-user" v-if="userIds.length > 0">
      已选 <strong>{{ userIds.length }}</strong> 用户
    </span>
    <el-button @click="openSelectUsersDialog">选择</el-button>
    <select-users-dialog
      v-model="userIds"
      @close="closeSelectUsersDialog"
      @confirmed="closeSelectUsersDialog"
      v-if="selectUsersDialogFlag"
    ></select-users-dialog>
  </div>
</template>

<script setup>
import { ref, watch } from "vue";
import SelectUsersDialog from "./SelectUsersDialog.vue";

const props = defineProps({
  modelValue: {
    type: Array,
    default: [],
  },
});
const emits = defineEmits(["update:modelValue"]);
const userIds = ref([...props.modelValue]);
const selectUsersDialogFlag = ref(false);

/**
 * 打开选择用户对话框
 */
const openSelectUsersDialog = () => {
  selectUsersDialogFlag.value = true;
};

/**
 * 关闭选择用户对话框
 */
const closeSelectUsersDialog = () => {
  selectUsersDialogFlag.value = false;
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

<style scoped>
.select-users {
  .selected-user {
    margin-right: var(--margin);
    strong {
      color: var(--color-primary);
    }
  }
}
</style>
