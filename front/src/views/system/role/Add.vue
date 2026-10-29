<template>
  <el-dialog
    :model-value="true"
    title="添加角色"
    width="700"
    :draggable="true"
    align-center
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="400px" class="scrollbar" v-loading="initLoading">
      <el-form
        :model="role"
        :rules="rules"
        scroll-to-error
        ref="roleRef"
        label-width="120px"
      >
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="role.name" />
        </el-form-item>
        <el-form-item label="功能权限" prop="permission_ids">
          <el-tree
            :data="treePermission"
            :props="{ children: 'children', label: 'name' }"
            node-key="id"
            show-checkbox
            ref="treePermissionRef"
            empty-text="无权限"
            @check="checkTreePermission"
          />
        </el-form-item>
        <el-form-item label="桌面端菜单" prop="desktop_menu_ids">
          <el-tree
            :data="desktopTreeMenu"
            :props="{ children: 'children', label: 'name' }"
            node-key="id"
            show-checkbox
            ref="desktopTreeMenuRef"
            empty-text="无菜单"
            @check="checkDesktopTreeMenu"
          />
        </el-form-item>
        <el-form-item label="桌面端路由" prop="desktop_route_ids">
          <el-tree
            :data="desktopRoutes"
            :props="{ children: 'children', label: 'name' }"
            node-key="id"
            show-checkbox
            ref="desktopRouteRef"
            empty-text="无路由"
            @check="checkDesktopRoutes"
          />
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" @click="submitForm" :loading="submitLoading">
        提交
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

const emits = defineEmits(["close", "submited"]);
const role = ref({
  permission_ids: [],
  desktop_menu_ids: [],
  desktop_route_ids: [],
});
const roleRef = ref({});
const rules = {
  name: [{ required: true, message: "请输入角色名称", trigger: "blur" }],
};
const initLoading = ref(true);
const submitLoading = ref(false);
const treePermission = ref([]);
const treePermissionRef = ref(null);
const desktopTreeMenu = ref([]);
const desktopTreeMenuRef = ref(null);
const desktopRoutes = ref([]);
const desktopRouteRef = ref([]);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.role.Add/init");
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
  treePermission.value = response.data.tree_permission;
  desktopTreeMenu.value = response.data.desktop_tree_menu;
  desktopRoutes.value = response.data.desktop_routes;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 选择权限
 */
const checkTreePermission = () => {
  const allKeys = treePermissionRef.value.getCheckedKeys(); //全选中
  const halfKeys = treePermissionRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.permission_ids = keys;
};

/**
 * 选择桌面端菜单
 */
const checkDesktopTreeMenu = () => {
  const allKeys = desktopTreeMenuRef.value.getCheckedKeys(); //全选中
  const halfKeys = desktopTreeMenuRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.desktop_menu_ids = keys;
};

/**
 * 选择桌面端路由
 */
const checkDesktopRoutes = () => {
  const allKeys = desktopRouteRef.value.getCheckedKeys(); //全选中
  const halfKeys = desktopRouteRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.desktop_route_ids = keys;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await roleRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post("desktop/system.role.Add/save", role.value);
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
.add {
  .scrollbar {
    padding-right: 50px;
  }
}
</style>
