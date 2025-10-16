<template>
  <el-dialog
    :model-value="true"
    title="添加权限"
    width="600"
    :draggable="true"
    align-center
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="400px" class="scrollbar">
      <el-form
        :model="permission"
        :rules="rules"
        scroll-to-error
        ref="permissionRef"
        label-width="120px"
      >
        <el-form-item label="上级权限" prop="permission_id">
          <tree-permission-select
            v-model="permission.permission_id"
            placeholder="无"
          ></tree-permission-select>
        </el-form-item>
        <el-form-item label="权限名称" prop="name">
          <el-input v-model="permission.name" />
        </el-form-item>
        <el-form-item label="权限标识" prop="key">
          <el-input v-model="permission.key" />
        </el-form-item>
        <el-form-item label="接口地址" prop="api_string">
          <el-input v-model="permission.api_string" type="textarea" rows="3" />
          <div class="text-tip">
            后端接口地址一行一个，格式：应用/控制器/方法
          </div>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="permission.sort" type="number" />
        </el-form-item>
      </el-form>
    </el-scrollbar>
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
import TreePermissionSelect from "@/components/mobile/TreePermissionSelect.vue";

const emits = defineEmits(["close", "submited"]);
const submitLoading = ref(false);
const permission = ref({
  sort: 0,
});
const permissionRef = ref();
const rules = {
  name: [{ required: true, message: "请输入权限名称", trigger: "blur" }],
  key: [{ required: true, message: "请输入权限标识", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }],
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
  await permissionRef.value.validate();
  submitLoading.value = true;
  const response = await axios.post(
    "desktop/system.mobile.permission.Add/save",
    permission.value
  );
  submitLoading.value = false;
  if (response.code != 1) {
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
.add {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
}
</style>
