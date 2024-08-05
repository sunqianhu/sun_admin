<template>
  <el-dialog
    :model-value="open"
    title="添加角色"
    width="700"
    :draggable="true"
    align-center
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="400px" class="scrollbar" v-loading="dialogLoading">
      <el-form :model="role" :rules="rules" scroll-to-error ref="roleRef" label-width="120px">
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="role.name" />
        </el-form-item>
        <el-form-item label="桌面端权限" prop="desktop_permission_ids">
          <el-tree
            :data="desktopPermissions"
            :props="{ children: 'children', label: 'name_key' }"
            node-key="id"
            show-checkbox
            ref="desktopPermissionRef"
            empty-text="无权限"
            @check="checkDesktopPermission"
          />
        </el-form-item>
        <el-form-item label="桌面端菜单" prop="desktop_menu_ids">
          <el-tree
            :data="desktopMenus"
            :props="{ children: 'children', label: 'name_url' }"
            node-key="id"
            show-checkbox
            ref="desktopMenuRef"
            empty-text="无菜单"
            @check="checkDesktopMenu"
          />
        </el-form-item>
        <el-form-item label="桌面端路由" prop="desktop_route_ids">
          <el-tree
            :data="desktopRoutes"
            :props="{ children: 'children', label: 'name_path' }"
            node-key="id"
            show-checkbox
            ref="desktopRouteRef"
            empty-text="无路由"
            @check="checkDesktopRoute"
          />
        </el-form-item>
        <el-form-item label="移动端权限" prop="mobile_permission_ids">
          <el-tree
            :data="mobilePermissions"
            :props="{ children: 'children', label: 'name_key' }"
            node-key="id"
            show-checkbox
            ref="mobilePermissionRef"
            empty-text="无权限"
            @check="checkMobilePermission"
          />
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
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

defineProps(["open"]);
const emits = defineEmits(["close", "submited"]);
const role = ref({
  desktop_permission_ids: [],
  desktop_menu_ids: [],
  desktop_route_ids: [],
  mobile_permission_ids: []
});
const roleRef = ref({});
const rules = {
  name: [{ required: true, message: "角色名称不能为空", trigger: "blur" }]
};
const dialogLoading = ref(true);
const submitLoading = ref(false);
const desktopPermissions = ref([]);
const desktopPermissionRef = ref(null);
const desktopMenus = ref([]);
const desktopMenuRef = ref(null);
const desktopRoutes = ref([]);
const desktopRouteRef = ref([]);
const mobilePermissions = ref([]);
const mobilePermissionRef = ref(null);

/**
 * 初始化
 */
const init = async () => {
  dialogLoading.value = true;
  const response = await axios.get("desktop/system.role.Add/init");
  dialogLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  desktopPermissions.value = response.data.desktop_permissions;
  desktopMenus.value = response.data.desktop_menus;
  desktopRoutes.value = response.data.desktop_routes;
  mobilePermissions.value = response.data.mobile_permissions;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 选择桌面端权限
 */
const checkDesktopPermission = () => {
  const allKeys = desktopPermissionRef.value.getCheckedKeys(); //全选中
  const halfKeys = desktopPermissionRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.desktop_permission_ids = keys;
};

/**
 * 选择桌面端菜单
 */
const checkDesktopMenu = () => {
  const allKeys = desktopMenuRef.value.getCheckedKeys(); //全选中
  const halfKeys = desktopMenuRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.desktop_menu_ids = keys;
};

/**
 * 选择桌面端路由
 */
const checkDesktopRoute = () => {
  const allKeys = desktopRouteRef.value.getCheckedKeys(); //全选中
  const halfKeys = desktopRouteRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.desktop_route_ids = keys;
};

/**
 * 选择移动端权限
 */
const checkMobilePermission = () => {
  const allKeys = mobilePermissionRef.value.getCheckedKeys(); //全选中
  const halfKeys = mobilePermissionRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.mobile_permission_ids = keys;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await roleRef.value.validate();

  submitLoading.value = true;
  const response = await axios.post("desktop/system.role.Add/save", role.value);
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
.add {
  .scrollbar {
    padding-right: 50px;
  }
}
</style>
