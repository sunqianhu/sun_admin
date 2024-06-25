<template>
  department
  <el-dialog
    :model-value="open"
    title="修改权限"
    width="600"
    :draggable="true"
    align-center
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="400px" class="scrollbar" v-loading="dialogLoading">
      <el-form
        :model="permission"
        :rules="rules"
        scroll-to-error
        ref="permissionRef"
        label-width="120px"
      >
        <el-form-item label="上级权限" prop="permission_id">
          <el-tree-select
            v-model="permission.permission_id"
            :data="treePermissions"
            :props="{ label: 'name' }"
            node-key="id"
            :render-after-expand="false"
            check-strictly
            placeholder="无"
            clearable
          />
        </el-form-item>
        <el-form-item label="权限名称" prop="name">
          <el-input v-model="permission.name" />
        </el-form-item>
        <el-form-item label="权限标识" prop="key">
          <el-input v-model="permission.key" />
        </el-form-item>
        <el-form-item label="接口地址" prop="api_string">
          <el-input v-model="permission.api_string" type="textarea" rows="3" />
          <div class="form-tip">后端接口地址一行一个，格式：应用/控制器/方法</div>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="permission.sort" type="number" />
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" @click="submitForm" :loading="submitLoading"> 提交 </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";

const props = defineProps(["open", "id"]);
const emits = defineEmits(["close", "submited"]);
const permission = ref({});
const permissionRef = ref();
const rules = {
  name: [{ required: true, message: "权限名称不能为空", trigger: "blur" }],
  key: [{ required: true, message: "权限标识不能为空", trigger: "blur" }],
  sort: [{ required: true, message: "排序不能为空", trigger: "blur" }]
};
const treePermissions = ref([]);
const dialogLoading = ref(true);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  dialogLoading.value = true;
  const response = await axios.get("desktop/system.mobile.permission.Edit/init", {
    params: { id: props.id }
  });
  dialogLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  treePermissions.value = response.data.tree_permissions;
  await nextTick();

  let data = response.data;
  if (data.permission.permission_id == 0) {
    data.permission.permission_id = "";
  }
  permission.value = data.permission;
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
  let response;
  try {
    response = await axios.post("desktop/system.mobile.permission.Edit/save", permission.value);
  } catch (error) {
    submitLoading.value = false;
    return;
  }
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
