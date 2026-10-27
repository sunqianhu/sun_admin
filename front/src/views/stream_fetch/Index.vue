<template>
  <div class="index">
    <div class="page-header">
      <div class="page-header__name">流式提取</div>
      <div class="page-header__description">主要用于大模型流式输出</div>
      <div class="page-header__action"></div>
    </div>
    <div v-html="resultMd" class="result"></div>
    <div class="error">{{ error }}</div>
    <div class="action">
      <el-button
        type="primary"
        class="button"
        :loading="loading"
        @click="submitFetch"
      >
        请求
      </el-button>
    </div>
  </div>
</template>

<script setup>
import "github-markdown-css/github-markdown-light.css";

import { ref, onMounted, computed } from "vue";
import streamFetch from "@/helper/stream_fetch";
import markdownit from "markdown-it";

const emits = defineEmits(["close"]);
const loading = ref(false);
const error = ref("");
const result = ref("");
const md = markdownit({
  html: true,
  breaks: true,
  linkify: true,
  typographer: true,
});
const resultMd = computed(() => {
  return md.render(result.value);
});

/**
 * 处理流数据
 * @param message
 */
const handleMessage = (message) => {
  if (message.startsWith("data:")) {
    message = message.slice(5).trim();
  }

  try {
    const messageJson = JSON.parse(message);

    //错误
    if (messageJson.type == "error") {
      error.value += messageJson.message;
      return;
    }

    if (messageJson.event == "text_chunk") {
      result.value += messageJson.message || "";
    }
  } catch (e) {
    console.warn("流解析错误:", e.message, message);
  }
};

/**
 * 提交提取
 */
const submitFetch = async () => {
  loading.value = true;
  error.value = "";
  try {
    await new Promise((resolve, reject) => {
      streamFetch.post(
        "desktop/stream_fetch.Index/fetch",
        {},
        {
          onMessage: handleMessage,
          onComplete: resolve,
          onError: reject,
        },
      );
    });
  } catch (requestError) {
    error.value = requestError.message;
  } finally {
    loading.value = false;
  }
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
    .page-header__action {
    }
  }
  .action {
    margin-top: var(--margin);
    text-align: center;
  }
  .result {
    margin-top: var(--margin);
    word-break: break-all;
  }
}
</style>
