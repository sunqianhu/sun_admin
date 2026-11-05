<template>
  <div class="test">
    <h3>多选上传测试</h3>
    <p>先在单选区域选择一张图片，再在多选区域一次选中两张图片。</p>
    <p>本页使用真实上传组件，模拟接口响应，不会上传到服务器。</p>

    <section v-for="test in tests" :key="test.module">
      <h4>{{ test.title }}</h4>
      <file-upload
        v-model="test.files"
        :module="test.module"
        :multiple="test.multiple"
        accept="image/*"
      >
        <van-button type="primary" icon="photograph">
          {{ test.multiple ? "选择多张图片" : "选择一张图片" }}
        </van-button>
      </file-upload>
      <p>{{ test.expected }}</p>
      <p>实际上传调用：{{ test.requests.length }} 次</p>
      <ul>
        <li v-for="(request, index) in test.requests" :key="index">
          第 {{ index + 1 }} 次：{{ request }}
        </li>
      </ul>
      <p>组件回传文件：{{ test.files.length }} 个</p>
      <pre>{{ getFilesText(test.files) }}</pre>
    </section>

    <van-button block @click="reset">清空后重新测试</van-button>
  </div>
</template>

<script setup>
import { ref, onBeforeUnmount } from "vue";
import axios from "@/helper/axios.js";
import FileUpload from "@/components/FileUpload.vue";

const tests = ref([
  {
    title: "单选对照",
    module: "test_single",
    multiple: false,
    expected: "预期：选择一张图片，上传调用 1 次，回传 1 个文件。",
    files: [],
    requests: [],
  },
  {
    title: "多选复现",
    module: "test_multiple",
    multiple: true,
    expected: "预期：一次选择两张图片，上传调用 2 次，回传 2 个文件。",
    files: [],
    requests: [],
  },
]);

/**
 * 仅模拟本页的上传请求，检查组件提交的文件
 */
const interceptor = axios.interceptors.request.use((config) => {
  if (config.url !== "mobile/FileUpload/upload") {
    return config;
  }
  const test = tests.value.find(
    (test) => test.module === config.data.get("module"),
  );
  if (!test) {
    return config;
  }

  config.adapter = async (config) => {
    const file = config.data.get("file");
    const isFile = file instanceof File;
    test.requests.push(
      isFile ? "收到文件：" + file.name : "未收到文件，file 字段为：" + file,
    );
    return {
      data: {
        code: isFile ? 0 : 1,
        message: isFile ? "模拟上传成功" : "没有收到有效文件",
        data: isFile ? { name: file.name, path: "test/" + file.name } : null,
      },
      status: 200,
      statusText: "OK",
      headers: {},
      config,
    };
  };
  return config;
});

/**
 * 显示回传文件，省略图片预览内容
 */
const getFilesText = (files) => {
  return JSON.stringify(
    files.map((file) => ({ name: file.name, path: file.path })),
    null,
    2,
  );
};

/**
 * 重置测试
 */
const reset = () => {
  for (const test of tests.value) {
    test.files = [];
    test.requests = [];
  }
};

onBeforeUnmount(() => {
  axios.interceptors.request.eject(interceptor);
});
</script>

<style lang="scss" scoped>
.test {
  min-height: 100vh;
  padding: 16px;
  box-sizing: border-box;
  background: var(--van-background);
  p {
    line-height: 1.6;
  }
  section {
    margin: 16px 0;
    padding: 16px;
    border-radius: 8px;
    background: var(--van-background-2);
  }
  pre {
    overflow: auto;
  }
}
</style>
