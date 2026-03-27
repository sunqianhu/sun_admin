<template>
  <div class="user-select">
    <span class="selected-user" v-if="userName !== ''">
      {{ userName }}
    </span>
    <el-button @click="openUserSelectDialog">选择</el-button>
    <user-select-dialog
      v-model="userId"
      @close="closeUserSelectDialog"
      @confirmed="handleConfirmed"
      v-if="userSelectDialogFlag"
    ></user-select-dialog>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from "vue";
import axios from "@/helper/axios";
import UserSelectDialog from "./UserSelectDialog.vue";

const userId = defineModel({
  type: Number,
  default: 0,
});
const userName = ref("");
const userSelectDialogFlag = ref(false);
const error = ref("");

/**
 * 得到用户姓名
 */
const getUserName = async () => {
  if (!userId.value) {
    userName.value = "";
    return;
  }
  const response = await axios.post(
    "desktop/components.UserSelect/getUserName",
    { user_id: userId.value },
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
const openUserSelectDialog = () => {
  userSelectDialogFlag.value = true;
};

/**
 * 关闭选择用户对话框
 */
const closeUserSelectDialog = () => {
  userSelectDialogFlag.value = false;
};

/**
 * 处理确认选择
 * @param selectedUser
 */
const handleConfirmed = (selectedUser) => {
  userName.value = selectedUser.name;
  closeUserSelectDialog();
};

watch(
  () => userId.value,
  async (newValue) => {
    getUserName();
  },
  {
    deep: true,
  },
);

onMounted(() => {
  getUserName();
});
</script>

<style lang="scss" scoped>
.user-select {
  .selected-user {
    margin-right: var(--margin-sm);
    strong {
      color: var(--color-primary);
    }
  }
}
</style>
