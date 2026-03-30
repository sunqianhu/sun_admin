<template>
  <div class="file-upload">
    <van-uploader
      v-model="files"
      :multiple="multiple"
      :after-read="upload"
      :max-count="maxCount"
      :accept="accept"
      :disabled="disabled"
      :deletable="deletable"
      :upload-icon="uploadIcon"
      @delete="deleteFile"
    >
      <template #default>
        <slot></slot>
      </template>
      <template #tip>
        <slot name="tip"></slot>
      </template>
    </van-uploader>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  modelValue: {
    type: Array,
    default: [],
  },
  name: {
    type: String,
    default: "file",
  },
  module: {
    type: String,
    default: "module1",
  },
  multiple: {
    type: Boolean,
    default: undefined,
  },
  maxCount: {
    type: Number,
    default: undefined,
  },
  accept: {
    type: String,
    default: undefined,
  },
  disabled: {
    type: Boolean,
    default: undefined,
  },
  deletable: {
    type: Boolean,
    default: undefined,
  },
  uploadIcon: {
    type: String,
    default: undefined,
  },
});
const emits = defineEmits(["update:modelValue", "success"]);
const files = ref([]);

/**
 * 初始化
 */
const init = () => {
  files.value = props.modelValue ? props.modelValue : [];
};

/**
 * 上传
 * @param file
 */
const upload = async (file) => {
  const formData = new FormData();
  formData.append(props.name, file.file);
  formData.append("module", props.module);

  file.status = "uploading";
  const response = await axios.post("mobile/FileUpload/upload", formData);
  file.status = "done";
  if (response.code != 0) {
    showFailToast(response.message);
    deleteFile(file);
    return;
  }
  updateFile(file, response.data);
  emits("update:modelValue", getFiles());
  emits("success", file);
};

/**
 * 删除文件
 * @param file
 */
const deleteFile = (file) => {
  const index = files.value.indexOf(file);
  if (index !== -1) {
    files.value.splice(index, 1);
  }
  emits("update:modelValue", getFiles());
};

/**
 * 更新文件
 * @param file
 * @param serverFile
 */
const updateFile = (file, serverFile) => {
  const index = files.value.indexOf(file);
  if (index === -1) {
    return;
  }
  files.push(serverFile);
};

/**
 * 得到文件集合
 */
const getFiles = () => {
  const currentFiles = files.value;
  if (currentFiles.length == 0) {
    return [];
  }

  let finalFiles = [];
  for (let currentFile of currentFiles) {
    if (!currentFile.path) {
      continue;
    }
    finalFiles.push(currentFile);
  }

  return finalFiles;
};

/**
 * 侦听props
 */
watch(
  () => props.modelValue,
  (newModelValue) => {
    init();
  },
  {
    deep: true,
  },
);

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.file-upload {
}
</style>
