<template>
  <el-dialog
    :model-value="true"
    title="修改菜单"
    :draggable="true"
    align-center
    width="600"
    @close="close"
    class="edit"
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
          <icon-picker v-model="menu.icon" />
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
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import TreeMenuSelect from "@/components/desktop/TreeMenuSelect.vue";

const props = defineProps(["id"]);
const emits = defineEmits(["close", "submited"]);
const initLoading = ref(false);
const menu = ref({
  sort: 0,
});
const menuRef = ref();
const rules = {
  name: [{ required: true, message: "请输入菜单名称", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }],
};
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.desktop.menu.Edit/init", {
      params: { id: props.id },
    });
  } finally {
    initLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  let data = response.data;
  if (data.menu_id == 0) {
    data.menu_id = "";
  }
  menu.value = data;
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
  await menuRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.desktop.menu.Edit/save",
      menu.value,
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
