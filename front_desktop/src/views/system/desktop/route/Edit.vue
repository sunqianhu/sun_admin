<template>
  <el-dialog
    :model-value="open"
    title="修改路由"
    :draggable="true"
    align-center
    width="600"
    @close="close"
    class="edit"
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
          <el-radio-group v-model="route.keep_alive">
            <el-radio :value="1">是</el-radio>
            <el-radio :value="2">否</el-radio>
          </el-radio-group>
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
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";
import LayoutSelect from "@/components/desktop/route/LayoutSelect.vue";

const props = defineProps("open", "id");
const emits = defineEmits(["close", "submited"]);
const initLoading = ref(false);
const route = ref({
  sort: 1
});
const routeRef = ref();
const rules = {
  name: [{ required: true, message: "路由名称不能为空", trigger: "blur" }],
  key: [{ required: true, message: "路由标识不能为空", trigger: "blur" }],
  path: [{ required: true, message: "路由路径不能为空", trigger: "blur" }],
  component_path: [
    { required: true, message: "组件路径不能为空", trigger: "blur" }
  ],
  keep_alive: [
    { required: true, message: "路由保活不能为空", trigger: "blur" }
  ],
  sort: [{ required: true, message: "排序不能为空", trigger: "blur" }]
};
const layouts = ref([]);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  const response = await axios.get("desktop/system.desktop.route.Edit/init", {
    params: { id: props.id }
  });
  initLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  let data = response.data;
  if (data.route_id == 0) {
    data.route_id = "";
  }
  route.value = data;
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
  await routeRef.value.validate();

  submitLoading.value = true;
  const response = await axios.post(
    "desktop/system.desktop.route.Edit/save",
    route.value
  );
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
