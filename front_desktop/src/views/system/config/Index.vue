<template>
  <div class="index" v-loading="pageLoading">
    <div class="page-name">系统设置</div>
    <el-form
      :model="configForm"
      label-width="120px"
      ref="configFormRef"
      class="form"
    >
      <el-form-item label="禁止访问IP" prop="denied_ip_string">
        <el-input
          v-model="configForm.denied_ip_string"
          type="textarea"
          :rows="5"
        />
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

const configForm = ref({});
const configFormRef = ref({});
const pageLoading = ref(true);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/system.config.Index/init");
  pageLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  configForm.value = response.data;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await configFormRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.config.Index/save",
      configForm.value
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
    font-size: var(--font-size-xl);
    font-weight: var(font-weight-bold);
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
