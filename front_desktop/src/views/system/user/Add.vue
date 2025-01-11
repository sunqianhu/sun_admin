<template>
  <el-dialog
    :model-value="open"
    title="添加用户"
    width="550"
    :draggable="true"
    @close="close"
    class="add"
    v-load
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="user" :rules="rules" scroll-to-error ref="userRef" label-width="120px">
        <el-form-item label="账号" prop="account">
          <el-input v-model="user.account" autocomplete="off" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="user.password" autocomplete="off" show-password />
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="user.name" />
        </el-form-item>
        <el-form-item label="手机号码" prop="phone">
          <el-input v-model="user.phone" />
        </el-form-item>
        <el-form-item label="所属部门" prop="department_id">
          <tree-department-select v-model="user.department_id"></tree-department-select>
        </el-form-item>
        <el-form-item label="角色">
          <role-select v-model="user.role_ids" multiple></role-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="user.status">
            <el-radio value="1">启用</el-radio>
            <el-radio value="0">停用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" :loading="submitLoading" @click="submitForm"> 提交 </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios";

defineProps(["open"]);
const emits = defineEmits(["close", "submited"]);

const user = ref({
  status: "1"
});
const userRef = ref();
const rules = {
  account: [{ required: true, message: "账号不能为空", trigger: "blur" }],
  password: [{ required: true, message: "密码不能为空", trigger: "blur" }],
  name: [{ required: true, message: "姓名不能为空", trigger: "blur" }],
  phone: [{ required: true, message: "手机号码不能为空", trigger: "blur" }],
  department_id: [{ required: true, message: "所属部门还未选择", trigger: "blur" }],
  status: [{ required: true, message: "状态还未选择", trigger: "blur" }]
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

  submitLoading.value = true;
  const response = await axios.post("desktop/system.user.Add/save", user.value);
  submitLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  ElMessage({
    message: response.message,
    type: "success"
  });
  emits("submited", true);
};
</script>
<style lang="scss" scoped>
.add {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
}
</style>
