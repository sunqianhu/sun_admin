<template>
  <!--
为什么需要封装上传组件
1、每次使用都要去组装上传请求头信息，及上传地址，使用起来繁琐。
2、服务器端上传失败时，原始组件没有自动处理，需要每次使用时去处理事件。
3、原始组件v-model的数据需要处理后才能提交到服务器，不是理想的上传服务器的信息。
  -->
  <el-upload
    ref="uploadRef"
    :action="action"
    v-model:file-list="files"
    :name="props.name"
    :headers="headers"
    :multiple="props.multiple"
    :accept="props.accept"
    :limit="props.limit"
    :disabled="props.disabled"
    :show-file-list="props.showFileList"
    :data="props.data"
    :drag="props.drag"
    :list-type="props.listType"
    :with-credentials="props.withCredentials"
    :crossorigin="props.crossorigin"
    :before-upload="handleBeforeUpload"
    :on-success="handleSuccess"
    :on-remove="handleRemove"
    :on-change="handleChange"
    :on-exceed="handleExceed"
    :on-progress="handleProgress"
    :on-error="handleError"
  >
    <template #default>
      <slot></slot>
    </template>
    <template #tip>
      <slot name="tip"></slot>
    </template>
    <template #file>
      <slot name="file"></slot>
    </template>
  </el-upload>
</template>

<script setup>
import { ref, watch } from "vue";

const props = defineProps({
  modelValue: {
    type: Array,
    default: [],
  },
  action: {
    type: String,
    default: undefined,
  },
  name: {
    type: String,
    default: "file",
  },
  multiple: {
    type: Boolean,
    default: undefined,
  },
  accept: {
    type: String,
    default: undefined,
  },
  limit: {
    type: Number,
    default: undefined,
  },
  disabled: {
    type: Boolean,
    default: undefined,
  },
  showFileList: {
    type: Boolean,
    default: undefined,
  },
  data: {
    type: Object,
    default: undefined,
  },
  listType: {
    type: String,
    default: undefined,
  },
  withCredentials: {
    type: Boolean,
    default: undefined,
  },
  crossorigin: {
    type: String,
    default: undefined,
  },
  drag: {
    type: Boolean,
    default: undefined,
  },
});
const emits = defineEmits([
  "update:modelValue",
  "success",
  "remove",
  "change",
  "exceed",
  "progress",
  "error",
  "beforeUpload",
]);
const headers = { token: localStorage.getItem("token") };
const files = ref(props.modelValue);
const uploadRef = ref(null);
let action = import.meta.env.VITE_API_PREFIX + "desktop/FileUpload/upload";
if (props.action) {
  action = import.meta.env.VITE_API_PREFIX + props.action;
}

/**
 * 处理上传前
 * @param rawFile
 */
const handleBeforeUpload = (rawFile) => {
  let result = emits("beforeUpload", rawFile);
  if (result === false) {
    return false;
  }
  return true;
};

/**
 * 处理上传成功
 * @param {*} response
 * @param {*} uploadFile
 * @param {*} uploadFiles
 */
const handleSuccess = async (response, uploadFile, uploadFiles) => {
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    await uploadRef.value.handleRemove(uploadFile);
    handleChange(uploadFile, uploadFiles);
    return;
  }

  emits("success", response, uploadFile, uploadFiles);
};

/**
 * 处理删除文件
 * @param {*} file
 * @param {*} uploadFiles
 */
const handleRemove = (uploadFile, uploadFiles) => {
  emits("remove", uploadFile, uploadFiles);
};

/**
 * 处理改变
 * @param {*} file
 * @param {*} uploadFiles
 */
const handleChange = (uploadFile, uploadFiles) => {
  emits("update:modelValue", getFiles());
  emits("change", uploadFile, uploadFiles);
};

/**
 * 处理超出限制
 * @param {Array} files 超出限制的文件
 * @param {Array} uploadFiles 已上传的文件
 */
const handleExceed = (files, uploadFiles) => {
  ElMessage({
    message: "最多只能上传" + props.limit + "个文件",
    type: "error",
  });
  emits("exceed", files, uploadFiles);
};

/**
 * 处理上传进度
 * @param {*} event
 * @param {*} uploadFile
 * @param {*} uploadFiles
 */
const handleProgress = (event, uploadFile, uploadFiles) => {
  emits("progress", event, uploadFile, uploadFiles);
};

/**
 * 处理文件上传失败
 * @param error
 * @param uploadFile
 * @param uploadFiles
 */
const handleError = (error, uploadFile, uploadFiles) => {
  ElMessage({
    message: error.message,
    type: "error",
  });
  emits("error", error, uploadFile, uploadFiles);
};

/**
 * 得到文件集合
 */
const getFiles = () => {
  if (!files.value || files.value.length === 0) {
    return [];
  }
  return files.value.map((file) => {
    const responseData = file.response?.data ?? {};
    return {
      ...file,
      ...responseData,
    };
  });
};

/**
 * 侦听props
 */
watch(
  () => props.modelValue,
  (newModelValue) => {
    files.value = newModelValue;
  },
  {
    deep: true,
  }
);
</script>

<style scoped></style>
