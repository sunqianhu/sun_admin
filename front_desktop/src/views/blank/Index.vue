<template>
  <div class="layout-blank">
    <router-view v-slot="{ Component, route }">
      <keep-alive v-if="route.meta.keep_alive == true">
        <component :is="Component" />
      </keep-alive>
      <component :is="Component" v-else />
    </router-view>
    <watermark />
  </div>
</template>

<script setup>
import Watermark from "@/components/Watermark.vue";
import { useDark, useToggle } from "@vueuse/core";

const isDark = useDark();
useToggle(isDark);
</script>

<style lang="scss" scoped>
.layout-blank {
  background-color: var(--background-color-base);
}
</style>
