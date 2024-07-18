<template>
  <el-dialog
    :model-value="open"
    title="修改角色"
    width="700"
    :draggable="true"
    align-center
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="400px" class="scrollbar" v-loading="dialogLoading">
      <el-form :model="role" :rules="rules" scroll-to-error ref="roleRef" label-width="120px">
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="role.name" />
        </el-form-item>
        <el-form-item label="桌面端菜单" prop="desktop_menu_ids">
          <el-tree
            :data="desktopMenus"
            :props="{ children: 'children', label: 'name_url' }"
            node-key="id"
            show-checkbox
            ref="desktopMenuRef"
            empty-text="无菜单"
            :default-checked-keys="desktopMenuDefaultCheckKeys"
            @check="checkDesktopMenu"
          />
        </el-form-item>
        <el-form-item label="桌面端权限" prop="desktop_permission_ids">
          <el-tree
            :data="desktopPermissions"
            :props="{ children: 'children', label: 'name_key' }"
            node-key="id"
            show-checkbox
            ref="desktopPermissionRef"
            empty-text="无权限"
            :default-checked-keys="desktopPermissionDefaultCheckKeys"
            @check="checkDesktopPermission"
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
            :default-checked-keys="desktopRouteDefaultCheckKeys"
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
            :default-checked-keys="mobilePermissionDefaultCheckKeys"
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
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";

const props = defineProps(["open", "id"]);
const emits = defineEmits(["close", "submited"]);
const role = ref({
  desktop_permission_ids: [],
  desktop_menu_ids: [],
  desktop_route_ids: [],
  mobile_permission_ids: []
});
const roleRef = ref();
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
const desktopPermissionDefaultCheckKeys = ref([]);
const desktopMenuDefaultCheckKeys = ref([]);
const desktopRouteDefaultCheckKeys = ref([]);
const mobilePermissionDefaultCheckKeys = ref([]);

/**
 * 初始化
 */
const init = async () => {
  dialogLoading.value = true;
  const response = await axios.get("desktop/system.role.Edit/init", {
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

  desktopPermissions.value = response.data.desktop_permissions;
  desktopMenus.value = response.data.desktop_menus;
  desktopRoutes.value = response.data.desktop_routes;
  mobilePermissions.value = response.data.mobile_permissions;
  await nextTick();

  role.value = response.data.role;
  desktopPermissionDefaultCheckKeys.value = getDesktopPermissionDefaultCheckKeys(
    response.data.role.desktop_permission_ids
  );
  desktopMenuDefaultCheckKeys.value = getDesktopMenuDefaultCheckKeys(
    response.data.role.desktop_menu_ids
  );
  desktopRouteDefaultCheckKeys.value = getDesktopRouteDefaultCheckKeys(
    response.data.role.desktop_route_ids
  );
  mobilePermissionDefaultCheckKeys.value = getMobilePermissionDefaultCheckKeys(
    response.data.role.mobile_permission_ids
  );
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 得到桌面端权限默认选中的key(排除父节点)
 * @param {array} desktopPermissionIds
 */
const getDesktopPermissionDefaultCheckKeys = (desktopPermissionIds) => {
  let finalPermissionIds = [];
  for (let i in desktopPermissionIds) {
    let desktopPermissionId = desktopPermissionIds[i];
    let node = desktopPermissionRef.value.getNode(desktopPermissionId);
    if (!node) {
      continue;
    }

    if (!node.childNodes || !node.childNodes.length) {
      finalPermissionIds.push(desktopPermissionId);
    }
  }
  return finalPermissionIds;
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
 * 得到桌面端菜单默认选中的key(排除父节点)
 * @param {array} desktopMenuIds
 */
const getDesktopMenuDefaultCheckKeys = (desktopMenuIds) => {
  let finalMenuIds = [];
  for (let i in desktopMenuIds) {
    let desktopMenuId = desktopMenuIds[i];
    let node = desktopMenuRef.value.getNode(desktopMenuId);
    if (!node) {
      continue;
    }

    if (!node.childNodes || !node.childNodes.length) {
      finalMenuIds.push(desktopMenuId);
    }
  }
  return finalMenuIds;
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
 * 得到桌面端路由默认选中的key(排除父节点)
 * @param {array} desktopRouteIds
 */
const getDesktopRouteDefaultCheckKeys = (desktopRouteIds) => {
  let finalRouteIds = [];
  for (let i in desktopRouteIds) {
    let desktopRouteId = desktopRouteIds[i];
    let node = desktopRouteRef.value.getNode(desktopRouteId);
    if (!node) {
      continue;
    }

    if (!node.childNodes || !node.childNodes.length) {
      finalRouteIds.push(desktopRouteId);
    }
  }
  return finalRouteIds;
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
 * 得到移动端权限默认选中的key(排除父节点)
 * @param {array} desktopPermissionIds
 */
const getMobilePermissionDefaultCheckKeys = (mobilePermissionIds) => {
  let finalPermissionIds = [];
  for (let i in mobilePermissionIds) {
    let mobilePermissionId = mobilePermissionIds[i];
    let node = mobilePermissionRef.value.getNode(mobilePermissionId);
    if (!node) {
      continue;
    }

    if (!node.childNodes || !node.childNodes.length) {
      finalPermissionIds.push(mobilePermissionId);
    }
  }
  return finalPermissionIds;
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
  const response = await axios.post("desktop/system.role.Edit/save", role.value);
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
