<template>
  <div class="file-view">
    <div class="label">附件：</div>
    <div class="content">
      <div v-for="file in files" class="file" v-if="files.length > 0">
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
  .label {
  }
  .content {
    flex: 1;
    .file {
    }
  }
}
</style>
