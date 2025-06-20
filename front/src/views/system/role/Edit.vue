<template>
  <el-dialog
    :model-value="true"
    title="修改角色"
    width="700"
    :draggable="true"
    align-center
    @close="close"
    class="edit"
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
        <el-form-item label="桌面端权限" prop="desktop_permission_ids">
          <el-tree
            :data="desktopTreePermission"
            :props="{ children: 'children', label: 'name' }"
            node-key="id"
            show-checkbox
            ref="desktopTreePermissionRef"
            empty-text="无权限"
            :default-checked-keys="desktopTreePermissionDefaultCheckKeys"
            @check="checkDesktopTreePermission"
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
            :default-checked-keys="desktopTreeMenuDefaultCheckKeys"
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
            :default-checked-keys="desktopRouteDefaultCheckKeys"
            @check="checkDesktopRoute"
          />
        </el-form-item>
        <el-form-item label="移动端权限" prop="mobile_permission_ids">
          <el-tree
            :data="mobileTreePermission"
            :props="{ children: 'children', label: 'name' }"
            node-key="id"
            show-checkbox
            ref="mobileTreePermissionRef"
            empty-text="无权限"
            :default-checked-keys="mobileTreePermissionDefaultCheckKeys"
            @check="checkMobileTreePermission"
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
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";

const props = defineProps(["id"]);
const emits = defineEmits(["close", "submited"]);
const role = ref({
  desktop_permission_ids: [],
  desktop_menu_ids: [],
  desktop_route_ids: [],
  mobile_permission_ids: [],
});
const roleRef = ref();
const rules = {
  name: [{ required: true, message: "请输入角色名称", trigger: "blur" }],
};
const initLoading = ref(true);
const submitLoading = ref(false);
const desktopTreePermission = ref([]);
const desktopTreePermissionRef = ref(null);
const desktopTreeMenu = ref([]);
const desktopTreeMenuRef = ref(null);
const desktopRoutes = ref([]);
const desktopRouteRef = ref([]);
const mobileTreePermission = ref([]);
const mobileTreePermissionRef = ref(null);

const desktopTreePermissionDefaultCheckKeys = ref([]);
const desktopTreeMenuDefaultCheckKeys = ref([]);
const desktopRouteDefaultCheckKeys = ref([]);
const mobileTreePermissionDefaultCheckKeys = ref([]);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  const response = await axios.get("desktop/system.role.Edit/init", {
    params: { id: props.id },
  });
  initLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  desktopTreePermission.value = response.data.desktop_tree_permission;
  desktopTreeMenu.value = response.data.desktop_tree_menu;
  desktopRoutes.value = response.data.desktop_routes;
  mobileTreePermission.value = response.data.mobile_tree_permission;
  await nextTick();

  role.value = response.data.role;
  desktopTreePermissionDefaultCheckKeys.value =
    getDesktopTreePermissionDefaultCheckKeys(
      response.data.role.desktop_permission_ids
    );
  desktopTreeMenuDefaultCheckKeys.value = getDesktopTreeMenuDefaultCheckKeys(
    response.data.role.desktop_menu_ids
  );
  desktopRouteDefaultCheckKeys.value = getDesktopRouteDefaultCheckKeys(
    response.data.role.desktop_route_ids
  );
  mobileTreePermissionDefaultCheckKeys.value =
    getMobileTreePermissionDefaultCheckKeys(
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
const getDesktopTreePermissionDefaultCheckKeys = (desktopPermissionIds) => {
  let finalPermissionIds = [];
  for (let i in desktopPermissionIds) {
    let desktopPermissionId = desktopPermissionIds[i];
    let node = desktopTreePermissionRef.value.getNode(desktopPermissionId);
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
const checkDesktopTreePermission = () => {
  const allKeys = desktopTreePermissionRef.value.getCheckedKeys(); //全选中
  const halfKeys = desktopTreePermissionRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.desktop_permission_ids = keys;
};

/**
 * 得到桌面端菜单默认选中的key(排除父节点)
 * @param {array} desktopMenuIds
 */
const getDesktopTreeMenuDefaultCheckKeys = (desktopMenuIds) => {
  let finalMenuIds = [];
  for (let i in desktopMenuIds) {
    let desktopMenuId = desktopMenuIds[i];
    let node = desktopTreeMenuRef.value.getNode(desktopMenuId);
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
const checkDesktopTreeMenu = () => {
  const allKeys = desktopTreeMenuRef.value.getCheckedKeys(); //全选中
  const halfKeys = desktopTreeMenuRef.value.getHalfCheckedKeys(); //半选中
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
const getMobileTreePermissionDefaultCheckKeys = (mobilePermissionIds) => {
  let finalPermissionIds = [];
  for (let i in mobilePermissionIds) {
    let mobilePermissionId = mobilePermissionIds[i];
    let node = mobileTreePermissionRef.value.getNode(mobilePermissionId);
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
const checkMobileTreePermission = () => {
  const allKeys = mobileTreePermissionRef.value.getCheckedKeys(); //全选中
  const halfKeys = mobileTreePermissionRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.mobile_permission_ids = keys;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await roleRef.value.validate();
  submitLoading.value = true;
  let response;
  try {
    response = await axios.post("desktop/system.role.Edit/save", role.value);
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
