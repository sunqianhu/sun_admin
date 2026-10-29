<template>
  <el-dialog
    :model-value="true"
    title="修改密码"
    width="500"
    :draggable="true"
    @close="close"
  >
    <div class="edit-password">
      <el-form
        :model="user"
        :rules="rules"
        scroll-to-error
        ref="userRef"
        label-width="120px"
      >
        <el-form-item label="新密码" prop="new_password1">
          <el-input
            type="password"
            show-password
            v-model="user.new_password1"
          />
        </el-form-item>
        <el-form-item label="确认新密码" prop="new_password2">
          <el-input
            type="password"
            show-password
            v-model="user.new_password2"
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

const props = defineProps(["id"]);
const emits = defineEmits(["close", "submited"]);
const user = ref({
  id: props.id,
});
const userRef = ref();
const rules = {
  new_password1: [{ required: true, message: "请输入新密码", trigger: "blur" }],
  new_password2: [
    { required: true, message: "请输入确认新密码", trigger: "blur" },
  ],
};
const submitLoading = ref(false);

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
  let response;
  try {
    submitLoading.value = true;
    response = await axios.post(
      "desktop/system.user.EditPassword/save",
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
