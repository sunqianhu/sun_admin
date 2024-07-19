<template>
  <div class="test">
    <upload-file v-model="files" module="rich_editor"></upload-file>
  </div>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios.js";

const files = ref([
  {
    name: "微信截图_20231226174102.png",
    path: "rich_editor/20240719/ddc467943d47e17f3b1f5e9c2b5da703.png",
    url: "/api/storage/rich_editor/20240719/ddc467943d47e17f3b1f5e9c2b5da703.png"
  }
]);

setInterval(() => {
  console.log(`output->files.value`, files.value);
}, 5000);
</script>

<style lang="scss" scoped>
.test {
  background: #ffffff;
  padding: 30px;
}
</style>
