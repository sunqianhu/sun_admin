<template>
  <div class="user-selector">
    <span class="selected-user" v-if="userName !== ''">
      {{ userName }}
    </span>
    <el-button @click="openUserSelectorDialog">选择</el-button>
    <user-selector-dialog
      v-model="userId"
      @close="closeUserSelectorDialog"
      @confirmed="handleConfirmed"
      v-if="userSelectorDialogFlag"
    ></user-selector-dialog>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from "vue";
import axios from "@/helper/axios";
import UserSelectorDialog from "./UserSelectorDialog.vue";

const userId = defineModel({
  type: Number,
  default: 0,
});
const userName = ref("");
const userSelectorDialogFlag = ref(false);

/**
 * 得到用户姓名
 */
const getUserName = async () => {
  if (!userId.value) {
    userName.value = "";
    return;
  }
  const response = await axios.post(
    "desktop/components.UserSelector/getUserName",
    { user_id: userId.value }
  );
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  userName.value = response.data;
};

/**
 * 打开选择用户对话框
 */
const openUserSelectorDialog = () => {
  userSelectorDialogFlag.value = true;
};

/**
 * 关闭选择用户对话框
 */
const closeUserSelectorDialog = () => {
  userSelectorDialogFlag.value = false;
};

/**
 * 处理确认选择
 * @param selectedUser
 */
const handleConfirmed = (selectedUser) => {
  userName.value = selectedUser.name;
  closeUserSelectorDialog();
};

watch(
  () => props.modelValue,
  async (newValue) => {
    userId.value = newValue;
    getUserName();
  },
  {
    deep: true,
  }
);

onMounted(() => {
  getUserName();
});
</script>

<style lang="scss" scoped>
.user-selector {
  .selected-user {
    margin-right: var(--margin-sm);
    strong {
      color: var(--color-primary);
    }
  }
}
</style>
