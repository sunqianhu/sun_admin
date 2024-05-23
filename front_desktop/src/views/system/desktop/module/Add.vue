<template>
  <el-dialog
    :model-value="open"
    title="添加模块"
    width="600"
    :draggable="true"
    align-center
    @close="handleClose"
    class="add"
  >
    <el-scrollbar max-height="350px" class="scrollbar">
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
          <div class="form-tip">模块的唯一标识，用于前端路由名称和权限指令标识</div>
        </el-form-item>
        <el-form-item label="路由路径" prop="path" v-if="module.type_id == 2">
          <el-input v-model="module.path" />
          <div class="form-tip">例如/system/user</div>
        </el-form-item>
        <el-form-item label="组件路径" prop="component" v-if="module.type_id == 2">
          <el-input v-model="module.component" />
          <div class="form-tip">相对于view目录</div>
        </el-form-item>
        <el-form-item
          label="菜单图标"
          prop="icon"
          v-if="module.type_id == 1 || module.type_id == 2 || module.type_id == 4"
        >
          <el-input v-model="module.icon" />
          <div class="form-tip">elementplus图标组件名</div>
        </el-form-item>
        <el-form-item label="接口地址" prop="api" v-if="module.type_id == 2 || module.type_id == 3">
          <el-input v-model="module.api" type="textarea" rows="3" />
          <div class="form-tip">后端接口网址一行一个，格式：应用/控制器/方法</div>
        </el-form-item>
        <el-form-item label="链接网址" prop="url" v-if="module.type_id == 4">
          <el-input v-model="module.url" />
        </el-form-item>
        <el-form-item label="页面布局" prop="layout" v-if="module.type_id == 2">
          <el-select v-model="module.layout" clearable>
            <el-option v-for="layout in layouts" :label="layout.value" :value="layout.key" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="module.remark" maxlength="32" />
        </el-form-item>
        <el-form-item label="保活" prop="keep_alive" v-if="module.type_id == 2">
          <el-radio-group v-model="module.keep_alive">
            <el-radio :label="1">是</el-radio>
            <el-radio :label="2">否</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item
          label="菜单显示"
          prop="show"
          v-if="module.type_id == 1 || module.type_id == 2 || module.type_id == 4"
        >
          <el-radio-group v-model="module.show">
            <el-radio :label="1">显示</el-radio>
            <el-radio :label="2">隐藏</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="module.sort" type="number" />
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" :loading="submitLoading" @click="handleFormSubmit">
        提交
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

defineProps(["open"]);
const emits = defineEmits(["close", "submited"]);
const submitLoading = ref(false);

const module = ref({
  type_id: 1,
  sort: 1,
  keep_alive: 2,
  show: 1
});
const moduleRef = ref();
const rules = {
  type_id: [{ required: true, message: "模块类型不能为空", trigger: "blur" }],
  name: [{ required: true, message: "模块名称不能为空", trigger: "blur" }],
  key: [{ required: true, message: "模块key不能为空", trigger: "blur" }],
  sort: [{ required: true, message: "排序不能为空", trigger: "blur" }]
};
const treeModules = ref([]);
const types = ref([]);
const layouts = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/system.desktop.Module/initAdd");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  treeModules.value = response.data.tree_modules;
  types.value = response.data.types;
  layouts.value = response.data.layouts;
};

/**
 * 处理关闭
 */
const handleClose = () => {
  emits("close", true);
};

/**
 * 处理表单提交
 */
const handleFormSubmit = async () => {
  await moduleRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post("desktop/system.desktop.Module/saveAdd", module.value);
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
.add {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
}
</style>
