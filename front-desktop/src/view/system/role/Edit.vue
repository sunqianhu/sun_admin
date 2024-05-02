<template>
  <el-dialog
    :model-value="open"
    title="修改角色"
    width="600"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="400px" class="scrollbar" v-loading="dialogLoading">
      <el-form :model="role" :rules="rules" scroll-to-error ref="roleRef" label-width="120px">
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="role.name" />
        </el-form-item>
        <el-form-item label="桌面端模块" prop="desktop_module_ids">
          <el-tree
            :props="{ children: 'children', label: 'name_remark' }"
            :data="desktopModules"
            show-checkbox
            node-key="id"
            ref="desktopModuleRef"
            empty-text="无模块"
            @check="checkDesktopModule"
            :default-checked-keys="desktopModuleDefaultCheckKeys"
          />
        </el-form-item>
        <el-form-item label="移动端模块" prop="mobile_module_ids">
          <el-tree
            :props="{ children: 'children', label: 'name_remark' }"
            :data="mobileModules"
            show-checkbox
            node-key="id"
            ref="mobileModuleRef"
            empty-text="无模块"
            @check="checkMobileModule"
            :default-checked-keys="mobileModuleDefaultCheckKeys"
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
  desktop_module_ids: [],
  mobile_module_ids: []
});
const roleRef = ref();
const rules = {
  name: [{ required: true, message: "角色名称不能为空", trigger: "blur" }]
};
const dialogLoading = ref(true);
const desktopModules = ref([]);
const desktopModuleRef = ref(null);
const desktopModuleDefaultCheckKeys = ref([]);
const mobileModules = ref([]);
const mobileModuleRef = ref(null);
const mobileModuleDefaultCheckKeys = ref([]);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  dialogLoading.value = true;
  const response = await axios.get("desktop/system.Role/initEdit", {
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

  desktopModules.value = response.data.desktop_modules;
  mobileModules.value = response.data.mobile_modules;
  role.value = response.data.role;
  await nextTick();
  desktopModuleDefaultCheckKeys.value = getDesktopModuleDefaultCheckKeys(
    response.data.role.desktop_module_ids
  );
  mobileModuleDefaultCheckKeys.value = getMobileModuleDefaultCheckKeys(
    response.data.role.mobile_module_ids
  );
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 得到桌面端模块默认选中的key(排除父节点)
 * @param {array} desktopModuleIds
 */
const getDesktopModuleDefaultCheckKeys = (desktopModuleIds) => {
  let finalModuleIds = [];
  let i;
  let desktopModuleId = 0;
  let node;

  for (i in desktopModuleIds) {
    desktopModuleId = desktopModuleIds[i];
    node = desktopModuleRef.value.getNode(desktopModuleId);
    if (!node) {
      continue;
    }

    if (!node.childNodes || !node.childNodes.length) {
      finalModuleIds.push(desktopModuleId);
    }
  }
  return finalModuleIds;
};

/**
 * 选择桌面端模块
 */
const checkDesktopModule = () => {
  const allKeys = desktopModuleRef.value.getCheckedKeys(); //全选中
  const halfKeys = desktopModuleRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.desktop_module_ids = keys;
};

/**
 * 得到移动端模块默认选中的key(排除父节点)
 * @param {array} desktopModuleIds
 */
const getMobileModuleDefaultCheckKeys = (mobileModuleIds) => {
  let finalModuleIds = [];
  let i;
  let mobileModuleId = 0;
  let node;

  for (i in mobileModuleIds) {
    mobileModuleId = mobileModuleIds[i];
    node = mobileModuleRef.value.getNode(mobileModuleId);
    if (!node) {
      continue;
    }

    if (!node.childNodes || !node.childNodes.length) {
      finalModuleIds.push(mobileModuleId);
    }
  }
  return finalModuleIds;
};

/**
 * 选择移动端模块
 */
const checkMobileModule = () => {
  const allKeys = mobileModuleRef.value.getCheckedKeys(); //全选中
  const halfKeys = mobileModuleRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.mobile_module_ids = keys;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await roleRef.value.validate();

  submitLoading.value = true;
  const response = await axios.post("desktop/system.Role/saveEdit", role.value);
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
