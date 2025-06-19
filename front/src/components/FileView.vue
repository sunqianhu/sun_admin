<template>
  <div class="file-view">
    <div class="file-view__label">附件：</div>
    <div class="file-view__content">
      <div
        v-for="file in files"
        class="file-view__file"
        v-if="files.length > 0"
      >
        <a
          :href="file.url + '?file_name=' + encodeURI(file.name)"
          target="_blank"
        >
          {{ file.name }}
        </a>
      </div>
      <span v-else>无</span>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  files: {
    type: Array,
    default: [],
  },
});
</script>

<style lang="scss" scoped>
.file-view {
  display: flex;
  .file-view__label {
  }
  .file-view__content {
    flex: 1;
    .file-view__file {
    }
  }
}
</style>
