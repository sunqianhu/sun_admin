<template>
  <el-dialog
    :model-value="true"
    title="添加路由"
    :draggable="true"
    align-center
    width="600"
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="400px" v-loading="initLoading" class="scrollbar">
      <el-form
        :model="route"
        :rules="rules"
        scroll-to-error
        ref="routeRef"
        label-width="120px"
      >
        <el-form-item label="路由名称" prop="name">
          <el-input v-model="route.name" />
        </el-form-item>
        <el-form-item label="路由标识" prop="key">
          <el-input v-model="route.key" />
        </el-form-item>
        <el-form-item label="路由路径" prop="path">
          <el-input v-model="route.path" />
        </el-form-item>
        <el-form-item label="组件路径" prop="component_path">
          <el-input v-model="route.component_path" />
        </el-form-item>
        <el-form-item label="布局容器" prop="layout">
          <layout-select v-model="route.layout"></layout-select>
        </el-form-item>
        <el-form-item label="保活" prop="keep_alive">
          <div>
            <el-radio-group v-model="route.keep_alive">
              <el-radio :value="1">是</el-radio>
              <el-radio :value="0">否</el-radio>
            </el-radio-group>
            <div class="text-tip">返回页后页面不重新载入数据</div>
          </div>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="route.sort" type="number" />
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
import LayoutSelect from "@/components/desktop/route/LayoutSelect.vue";

const emits = defineEmits(["close", "submited"]);
const initLoading = ref(false);
const route = ref({
  sort: 1,
  keep_alive: 2,
});
const routeRef = ref();
const rules = {
  name: [{ required: true, message: "路由名称不能为空", trigger: "blur" }],
  key: [{ required: true, message: "路由标识不能为空", trigger: "blur" }],
  path: [{ required: true, message: "路由路径不能为空", trigger: "blur" }],
  component_path: [
    { required: true, message: "组件路径不能为空", trigger: "blur" },
  ],
  keep_alive: [
    { required: true, message: "路由保活不能为空", trigger: "blur" },
  ],
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
  await routeRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.desktop.route.Add/save",
      route.value
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
