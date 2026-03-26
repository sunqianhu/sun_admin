<template>
  <div class="index">
    <div class="page-header">
      <span class="page-header__name">生成API令牌</span>
      <span class="page-header__description"> API令牌用于授权接口访问。 </span>
    </div>
    <div class="main">
      <div class="token" v-if="token !== ''">
        <div>{{ token }}</div>
      </div>
      <el-button
        type="primary"
        class="button"
        @click="submitForm"
        :loading="submitLoading"
      >
        生成
      </el-button>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios";

const submitLoading = ref(false);
const token = ref("");

/**
 * 提交表单
 */
const submitForm = async () => {
  submitLoading.value = true;
  const response = await axios.post(
    "desktop/system.api_token_generate.Index/generate",
  );
  submitLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  token.value = response.data;
};
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-light);
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-header {
    display: flex;
    .page-header__name {
      font-size: var(--font-size-lg);
    }
    .page-header__description {
      color: var(--font-color-secondary);
      margin-left: var(--margin);
      flex: 1;
    }
  }
  .main {
    margin-top: 100px;
    min-height: 300px;
    text-align: center;
    .token {
      margin-bottom: var(--margin);
    }
  }
}
</style>
