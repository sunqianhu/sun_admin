<template>
  <t-config-provider :global-config="zhCn">
    <RouterView />
  </t-config-provider>
</template>

<script setup>
import { RouterView } from "vue-router";
import zhCn from "tdesign-mobile-vue/es/locale/zh_CN";
</script>

<style scoped></style>
