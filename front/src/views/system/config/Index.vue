<template>
  <div class="index" v-loading="initLoading">
    <div class="page-name">系统设置</div>
    <el-form
      :model="config"
      :rules="rules"
      label-width="120px"
      ref="configRef"
      class="form"
    >
      <el-form-item label="系统名称" prop="system_name">
        <el-input v-model="config.system_name" />
      </el-form-item>
      <el-form-item label="系统简介" prop="system_description">
        <el-input
          v-model="config.system_description"
          type="textarea"
          :rows="4"
          :maxlength="65535"
          show-word-limit
        />
      </el-form-item>
      <el-form-item label="禁止访问IP" prop="denied_ips_string">
        <el-input v-model="config.denied_ips_string" type="textarea" :rows="5" />
        <div class="text-tip">一行一个</div>
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          class="button"
          @click="submitForm"
          :loading="submitLoading"
        >
          保存
        </el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

const config = ref({});
const configRef = ref({});
const rules = {
  system_name: [{ required: true, message: "请输入系统名称", trigger: "blur" }],
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
    response = await axios.get("desktop/system.config.Index/init");
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

  config.value = response.data;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await configRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.config.Index/save",
      config.value,
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
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-light);
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-name {
    font-size: var(--font-size-lg);
    font-weight: var(--font-weight-bold);
  }
  .form {
    width: 500px;
    margin-top: 16px;
    .el-select {
      width: 100%;
    }
    .submit-wrap {
      padding-left: 130px;
    }
  }
}
</style>
