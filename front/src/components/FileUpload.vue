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
    class="file-upload"
  >
    <template #default>
      <el-popover
        :visible="showPopoverProgress && uploading"
        placement="bottom-end"
        :width="350"
      >
        <template #reference>
          <slot :uploading="uploading"></slot>
        </template>
        <slot name="progress" :files="uploadingFiles" :abort="abort">
          <div class="upload-progress">
            <div
              v-for="file in uploadingFiles"
              :key="file.uid"
              class="upload-progress__item"
            >
              <div class="upload-progress__header">
                <span class="upload-progress__name" :title="file.name">
                  {{ file.name }}
                </span>
                <span class="upload-progress__percentage">
                  {{ file.percentage || 0 }}%
                </span>
              </div>
              <el-progress
                :percentage="file.percentage || 0"
                :show-text="false"
                :stroke-width="4"
                class="upload-progress__bar"
              />
              <div class="upload-progress__footer">
                <span>
                  {{ formatFileSize(getUploadedFileSize(file)) }} /
                  {{ formatFileSize(file.size) }}
                </span>
                <el-tooltip content="取消上传">
                  <el-button
                    link
                    :icon="Close"
                    class="upload-progress__cancel"
                    @click.stop="abort(file)"
                  />
                </el-tooltip>
              </div>
            </div>
          </div>
        </slot>
      </el-popover>
    </template>
    <template v-if="$slots.tip" #tip>
      <slot name="tip"></slot>
    </template>
    <template v-if="$slots.file" #file="{ file, index }">
      <slot name="file" :file="file" :index="index"></slot>
    </template>
  </el-upload>
</template>

<script setup>
import { computed, ref } from "vue";
import { Close } from "@element-plus/icons-vue";

const props = defineProps({
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
  showPopoverProgress: {
    type: Boolean,
    default: true,
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
  "success",
  "remove",
  "change",
  "exceed",
  "progress",
  "error",
  "abort",
  "beforeUpload",
]);
const files = defineModel({
  type: Array,
  default: () => [],
});
const headers = { token: localStorage.getItem("token") || "" };
const uploadRef = ref(null);
const uploadingFiles = computed(() =>
  files.value.filter((file) => ["ready", "uploading"].includes(file.status)),
); //上传中的文件列表
const uploading = computed(() => uploadingFiles.value.length > 0); //上传中
const showPopoverProgress = ref(props.showPopoverProgress);
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
  if (response.code != 0) {
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
 * 取消上传
 * @param uploadFile
 */
const abort = async (uploadFile) => {
  if (!uploadFile) {
    return;
  }
  await uploadRef.value?.handleRemove(uploadFile);
  emits("abort", uploadFile);
};

/**
 * 格式化文件大小
 * @param {number} size
 */
const formatFileSize = (size) => {
  if (!size) {
    return "0 B";
  }
  if (size < 1024) {
    return `${size} B`;
  }
  if (size < 1024 * 1024) {
    return `${(size / 1024).toFixed(1)} KB`;
  }
  if (size < 1024 * 1024 * 1024) {
    return `${(size / 1024 / 1024).toFixed(1)} MB`;
  }
  return `${(size / 1024 / 1024 / 1024).toFixed(1)} GB`;
};

/**
 * 得到文件已上传大小
 * @param file
 */
const getUploadedFileSize = (file) => {
  return Math.round(((file.size || 0) * (file.percentage || 0)) / 100);
};
</script>

<style lang="scss" scoped>
.file-upload {
  display: inline-flex;
  vertical-align: middle;
}
.upload-progress {
  .upload-progress__item {
    & + .upload-progress__item {
      padding-top: var(--padding);
      margin-top: var(--margin);
      border-top: 1px solid var(--border-color);
    }
    .upload-progress__header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: var(--margin-sm);
      .upload-progress__name {
        width: 230px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }
      .upload-progress__percentage {
        color: var(--color-primary);
        font-weight: var(--font-weight-bold);
      }
    }
    .upload-progress__bar {
      margin-top: var(--margin-sm);
    }
    .upload-progress__footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-top: var(--margin-sm);
      color: var(--font-color-secondary);
      font-size: var(--font-size-sm);
      .upload-progress__cancel {
        width: 24px;
        height: 24px;
      }
    }
  }
}
</style>
