<template>
  <div class="users-select">
    <span class="selected-user" v-if="userIds.length > 0">
      已选 <strong>{{ userIds.length }}</strong> 用户
    </span>
    <el-button @click="openUsersSelectDialog">选择</el-button>
    <users-select-dialog
      v-model="userIds"
      @close="closeUsersSelectDialog"
      @confirmed="closeUsersSelectDialog"
      v-if="usersSelectDialogFlag"
    ></users-select-dialog>
  </div>
</template>

<script setup>
import { ref } from "vue";
import UsersSelectDialog from "./UsersSelectDialog.vue";

const props = defineProps({
  topDepartmentId: {
    type: Number,
    default: 0,
  },
});
const userIds = defineModel({
  type: Array,
  default: [],
});
const usersSelectDialogFlag = ref(false);

/**
 * 打开选择用户对话框
 */
const openUsersSelectDialog = () => {
  usersSelectDialogFlag.value = true;
};

/**
 * 关闭选择用户对话框
 */
const closeUsersSelectDialog = () => {
  usersSelectDialogFlag.value = false;
};
</script>

<style lang="scss" scoped>
.users-select {
  .selected-user {
    margin-right: var(--margin-sm);
    strong {
      color: var(--color-primary);
    }
  }
}
</style>
