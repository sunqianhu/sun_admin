<template>
  <sidebar v-if="themeStore.mainLayout_layoutType === 'sidebar'"></sidebar>
  <top-navigation
    v-if="themeStore.mainLayout_layoutType === 'top_navigation'"
  ></top-navigation>
  <theme-setting-form></theme-setting-form>
  <watermark />
  <popup-message />
</template>

<script setup>
import Sidebar from "./main/Sidebar.vue";
import TopNavigation from "./main/TopNavigation.vue";
import ThemeSettingForm from "./main/ThemeSettingForm.vue";
import { useThemeStore } from "@/stores/theme";

const themeStore = useThemeStore();
</script>

<style lang="scss" scoped></style>
