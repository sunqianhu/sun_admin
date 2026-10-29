<template>
  <el-dialog
    :model-value="true"
    title="修改密码"
    width="500"
    :draggable="true"
    @close="close"
  >
    <div class="edit-password">
      <el-form :model="user" :rules="rules" ref="userRef" label-width="120px">
        <el-form-item label="原密码" prop="old_password">
          <el-input
            type="password"
            show-password
            v-model="user.old_password"
            autocomplete="current-password"
          />
        </el-form-item>
        <el-form-item label="新密码" prop="new_password1">
          <el-input
            type="password"
            show-password
            v-model="user.new_password1"
            autocomplete="new-password"
          />
        </el-form-item>
        <el-form-item label="确认新密码" prop="new_password2">
          <el-input
            type="password"
            show-password
            v-model="user.new_password2"
            autocomplete="new-password"
          />
        </el-form-item>
      </el-form>
    </div>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" :loading="submitLoading" @click="submitForm">
        提交
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios";

const emits = defineEmits(["close", "submited"]);
const user = ref({});
const userRef = ref();
const submitLoading = ref(false);
const rules = {
  old_password: [
    { required: true, message: "原密码不能为空", trigger: "blur" },
  ],
  new_password1: [
    { required: true, message: "新密码不能为空", trigger: "blur" },
  ],
  new_password2: [
    { required: true, message: "确认新密码不能为空", trigger: "blur" },
  ],
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await userRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/layouts.main.user.EditPassword/save",
      user.value,
    );
  } finally {
    submitLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  ElMessage({
    message: response.message,
    type: "success",
  });
  emits("submited", true);
};
</script>
<style lang="scss" scoped>
.edit-password {
  padding-right: 50px;
}
</style>
