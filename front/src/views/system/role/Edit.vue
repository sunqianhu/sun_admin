<template>
  <el-dialog
    :model-value="true"
    title="修改角色"
    width="600"
    :draggable="true"
    align-center
    class="edit"
    @close="close"
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
          <el-tree-select
            v-model="role.permission_ids"
            :data="treePermission"
            :props="{ children: 'children', label: 'name' }"
            node-key="id"
            multiple
            show-checkbox
            check-on-click-node
            collapse-tags
            collapse-tags-tooltip
            filterable
            clearable
            ref="treePermissionRef"
            placeholder="请选择"
          />
        </el-form-item>
        <el-form-item label="桌面端菜单" prop="desktop_menu_ids">
          <el-tree-select
            v-model="role.desktop_menu_ids"
            :data="desktopTreeMenu"
            :props="{ children: 'children', label: 'name' }"
            node-key="id"
            multiple
            show-checkbox
            check-on-click-node
            collapse-tags
            collapse-tags-tooltip
            filterable
            clearable
            ref="desktopTreeMenuRef"
            placeholder="请选择"
          />
        </el-form-item>
        <el-form-item label="桌面端路由" prop="desktop_route_ids">
          <el-select
            v-model="role.desktop_route_ids"
            multiple
            collapse-tags
            collapse-tags-tooltip
            filterable
            clearable
            placeholder="请选择"
          >
            <el-option
              v-for="route in desktopRoutes"
              :key="route.id"
              :label="route.name"
              :value="route.id"
            />
          </el-select>
        </el-form-item>
        <el-divider content-position="left" v-if="dataScopes.length">
          数据权限
        </el-divider>
        <el-form-item
          v-for="(dataScope, index) in dataScopes"
          :key="dataScope.id"
          :label="dataScope.name"
        >
          <el-select
            v-model="role.policy_ids[index]"
            placeholder="请选择"
            clearable
          >
            <el-option
              v-for="policy in dataScope.policies"
              :key="policy.id"
              :label="policy.name"
              :value="policy.id"
            />
          </el-select>
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

const props = defineProps(["id"]);
const emits = defineEmits(["close", "submited"]);
const role = ref({
  permission_ids: [],
  policy_ids: [],
  desktop_menu_ids: [],
  desktop_route_ids: [],
});
const roleRef = ref();
const rules = {
  name: [{ required: true, message: "请输入角色名称", trigger: "blur" }],
};
const initLoading = ref(true);
const submitLoading = ref(false);
const treePermission = ref([]);
const treePermissionRef = ref(null);
const dataScopes = ref([]);
const desktopTreeMenu = ref([]);
const desktopTreeMenuRef = ref(null);
const desktopRoutes = ref([]);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.role.Edit/init", {
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

  treePermission.value = response.data.tree_permission;
  dataScopes.value = response.data.data_scopes;
  desktopTreeMenu.value = response.data.desktop_tree_menu;
  desktopRoutes.value = response.data.desktop_routes;
  role.value = response.data.role;

  role.value.permission_ids = getLeafIds(
    treePermission.value,
    role.value.permission_ids,
  );

  const policyIds = role.value.policy_ids;
  role.value.policy_ids = dataScopes.value.map((dataScope) => {
    const selectedPolicy = dataScope.policies.find((policy) => {
      return policyIds.includes(policy.id);
    });
    return selectedPolicy?.id;
  });

  role.value.desktop_menu_ids = getLeafIds(
    desktopTreeMenu.value,
    role.value.desktop_menu_ids,
  );
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 回显时仅绑定叶子节点，避免父节点导致未授权的子节点被选中
 */
const getLeafIds = (nodes, ids) => {
  const leafIds = [];
  for (const node of nodes) {
    if (node.children && node.children.length) {
      leafIds.push(...getLeafIds(node.children, ids));
    } else if (ids.includes(node.id)) {
      leafIds.push(node.id);
    }
  }
  return leafIds;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await roleRef.value.validate();

  //提交时包含父节点，保证权限和菜单层级完整
  const data = {
    ...role.value,
    policy_ids: role.value.policy_ids.filter(Boolean),
    permission_ids: [
      ...treePermissionRef.value.getCheckedKeys(),
      ...treePermissionRef.value.getHalfCheckedKeys(),
    ],
    desktop_menu_ids: [
      ...desktopTreeMenuRef.value.getCheckedKeys(),
      ...desktopTreeMenuRef.value.getHalfCheckedKeys(),
    ],
  };
  submitLoading.value = true;
  let response;
  try {
    response = await axios.post("desktop/system.role.Edit/save", data);
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
