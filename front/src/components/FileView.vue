<template>
  <div class="file-view">
    <div class="file-view__label">附件：</div>
    <div class="file-view__content">
      <div
        v-for="file in files"
        class="file-view__file"
        v-if="files.length > 0"
      >
        <el-icon class="file-view__icon"><Paperclip /></el-icon>
        <a :href="getUrl(file)" target="_blank">
          {{ file.name }}
        </a>
      </div>
      <span v-else>无</span>
    </div>
  </div>
</template>

<script setup>
import { Paperclip } from "@element-plus/icons-vue";

const props = defineProps({
  files: {
    type: Array,
    default: [],
  },
});

/**
 * 得到下载网址
 * @param file
 */
const getUrl = (file) => {
  const url = new URL(file.url, window.location.origin);
  url.searchParams.set("file_name", encodeURIComponent(file.name));
  return url.toString();
};
</script>

<style lang="scss" scoped>
.file-view {
  display: flex;
  .file-view__label {
  }
  .file-view__content {
    flex: 1;
    .file-view__file {
      .file-view__icon {
        margin-right: 4px;
      }
    }
  }
}
</style>
