<template>
  <el-dialog
    :model-value="true"
    title="修改数据权限"
    width="500"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="300px" v-loading="initLoading" class="scrollbar">
      <el-form
        :model="dataScope"
        :rules="rules"
        scroll-to-error
        ref="dataScopeRef"
        label-width="100px"
      >
        <el-form-item label="名称" prop="name">
          <el-input v-model="dataScope.name" />
        </el-form-item>
        <el-form-item label="标识" prop="key">
          <el-input v-model="dataScope.key" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="dataScope.sort" type="number" />
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

const props = defineProps(["id"]);
const emits = defineEmits(["close", "submited"]);
const dataScope = ref({});
const dataScopeRef = ref();
const rules = {
  name: [{ required: true, message: "请输入名称", trigger: "blur" }],
  key: [{ required: true, message: "请输入标识", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }],
};
const initLoading = ref(false);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.data_scope.Edit/init", {
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
  dataScope.value = response.data;
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
  await dataScopeRef.value.validate();
  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.data_scope.Edit/save",
      dataScope.value,
    );
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
