<template>
  <div class="select-user">
    <span class="selected-user" v-if="userName !== ''">
      {{ userName }}
    </span>
    <el-button @click="openSelectUserDialog">选择</el-button>
    <select-user-dialog
      v-model="userId"
      @close="closeSelectUserDialog"
      @confirmed="handleConfirmed"
      v-if="selectUsersDialogFlag"
    ></select-user-dialog>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from "vue";
import axios from "@/helper/axios";
import SelectUserDialog from "./SelectUserDialog.vue";

const props = defineProps({
  modelValue: {
    type: Number,
    default: 0,
  },
});
const emits = defineEmits(["update:modelValue"]);
const userId = ref(props.modelValue);
const userName = ref("");
const selectUsersDialogFlag = ref(false);

/**
 * 得到用户姓名
 */
const getUserName = async () => {
  const response = await axios.post(
    "desktop/components.SelectUser/getUserName",
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
const openSelectUserDialog = () => {
  selectUsersDialogFlag.value = true;
};

/**
 * 关闭选择用户对话框
 */
const closeSelectUserDialog = () => {
  selectUsersDialogFlag.value = false;
};

/**
 * 处理确认选择
 * @param selectedUser
 */
const handleConfirmed = (selectedUser) => {
  userName.value = selectedUser.name;
  closeSelectUserDialog();
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
watch(
  () => userId.value,
  (newValue) => {
    emits("update:modelValue", newValue);
  },
  {
    deep: true,
  }
);

onMounted(() => {
  getUserName();
});
</script>

<style scoped>
.select-user {
  .selected-user {
    margin-right: var(--margin);
    strong {
      color: var(--color-primary);
    }
  }
}
</style>
