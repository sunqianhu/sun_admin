<template>
  department
  <el-dialog
    :model-value="open"
    title="修改模块"
    width="600"
    :draggable="true"
    align-center
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="350px" class="scrollbar" v-loading="pageLoading">
      <el-form :model="module" :rules="rules" scroll-to-error ref="moduleRef" label-width="120px">
        <el-form-item label="上级模块" prop="module_id">
          <el-tree-select
            v-model="module.module_id"
            :data="treeModules"
            :render-after-expand="false"
            check-strictly
            placeholder="无"
            clearable
          />
        </el-form-item>
        <el-form-item label="模块类型" prop="type_id">
          <el-radio-group v-model="module.type_id">
            <el-radio v-for="type in types" :key="type.key" :label="parseInt(type.key)">
              {{ type.value }}
            </el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="模块名称" prop="name">
          <el-input v-model="module.name" />
        </el-form-item>
        <el-form-item label="模块key" prop="key">
          <el-input v-model="module.key" />
          <div class="form-tip">模块的唯一标识，用于前端权限指令标识</div>
        </el-form-item>
        <el-form-item label="接口地址" prop="api" v-if="module.type_id == 2 || module.type_id == 3">
          <el-input v-model="module.api" type="textarea" rows="3" />
          <div class="form-tip">后端接口网址一行一个，格式：应用/控制器/方法</div>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="module.remark" maxlength="32" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="module.sort" type="number" />
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
const module = ref({});
const moduleRef = ref();
const rules = {
  type_id: [{ required: true, message: "模块类型不能为空", trigger: "blur" }],
  name: [{ required: true, message: "模块名称不能为空", trigger: "blur" }],
  key: [{ required: true, message: "模块key不能为空", trigger: "blur" }],
  sort: [{ required: true, message: "排序不能为空", trigger: "blur" }]
};
const treeModules = ref([]);
const types = ref([]);
const pageLoading = ref(true);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  pageLoading.value = true;
  const response = await axios.get("desktop/system.mobile.Module/initEdit", {
    params: { id: props.id }
  });
  pageLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  treeModules.value = response.data.tree_modules;
  types.value = response.data.types;
  await nextTick();

  if (response.data.module.module_id == "0") {
    response.data.module.module_id = "";
  }
  module.value = response.data.module;
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
  await moduleRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post("desktop/system.mobile.Module/saveEdit", module.value);
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
