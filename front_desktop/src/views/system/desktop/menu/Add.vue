<template>
  <el-dialog
    :model-value="true"
    title="添加菜单"
    :draggable="true"
    align-center
    width="600"
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="400px" v-loading="initLoading" class="scrollbar">
      <el-form
        :model="menu"
        :rules="rules"
        scroll-to-error
        ref="menuRef"
        label-width="120px"
      >
        <el-form-item label="上级菜单" prop="menu_id">
          <tree-menu-select
            v-model="menu.menu_id"
            placeholder="无"
          ></tree-menu-select>
        </el-form-item>
        <el-form-item label="菜单名称" prop="name">
          <el-input v-model="menu.name" />
        </el-form-item>
        <el-form-item label="菜单网址" prop="url">
          <el-input v-model="menu.url" />
        </el-form-item>
        <el-form-item label="菜单图标" prop="icon">
          <el-input v-model="menu.icon" />
        </el-form-item>
        <el-form-item label="打开方式" prop="target">
          <el-radio-group v-model="menu.target">
            <el-radio :value="1">本窗口</el-radio>
            <el-radio :value="9">新窗口</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="menu.sort" type="number" />
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
import TreeMenuSelect from "@/components/desktop/TreeMenuSelect.vue";

const emits = defineEmits(["close", "submited"]);
const initLoading = ref(false);
const menu = ref({
  target: 1,
  sort: 1,
});
const menuRef = ref();
const rules = {
  name: [{ required: true, message: "菜单名称不能为空", trigger: "blur" }],
  sort: [{ required: true, message: "排序不能为空", trigger: "blur" }],
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
  await menuRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.desktop.menu.Add/save",
      menu.value
    );
  } catch (error) {
    submitLoading.value = false;
    return;
  }
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
