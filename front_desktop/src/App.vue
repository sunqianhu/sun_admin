<template>
  <el-config-provider :locale="zhCn">
    <RouterView />
    <watermark />
    <message />
  </el-config-provider>
</template>

<script setup>
import zhCn from "element-plus/dist/locale/zh-cn.mjs";
import Watermark from "@/components/Watermark.vue";
import Message from "@/components/Message.vue";
</script>

<style scoped></style>
