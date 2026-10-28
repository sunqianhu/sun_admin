<template>
  <el-config-provider :locale="zhCn">
    <RouterView />
  </el-config-provider>
</template>

<script setup>
import { useDark } from "@vueuse/core";
import zhCn from "element-plus/dist/locale/zh-cn.mjs";

useDark();
</script>

<style scoped></style>
