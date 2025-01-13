<template>
  <el-dialog
    :model-value="open"
    title="修改用户"
    width="500"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="300px" v-loading="initLoading" class="scrollbar">
      <el-form :model="user" :rules="rules" scroll-to-error ref="userRef" label-width="120px">
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
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" :Loading="submitLoading" @click="submitForm"> 提交 </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";

const props = defineProps(["open", "id"]);
const emits = defineEmits(["close", "submited"]);

const user = ref({
  id: props.id
});
const userRef = ref();
const rules = {
  name: [{ required: true, message: "姓名不能为空", trigger: "blur" }],
  phone: [{ required: true, message: "手机号码不能为空", trigger: "blur" }],
  department_id: [{ required: true, message: "所属部门还未选择", trigger: "blur" }]
};
const initLoading = ref(false);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response = await axios.get("desktop/system.user.Edit/init", {
    params: { id: props.id }
  });
  initLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  user.value = response.data;
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
  const response = await axios.post("desktop/system.user.Edit/save", user.value);
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

onMounted(() => {
  init();
});
</script>
<style lang="scss" scoped>
.edit {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
}
</style>
