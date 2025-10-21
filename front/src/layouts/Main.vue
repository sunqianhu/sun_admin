<template>
  <sidebar-layout
    v-if="themeStore.mainLayout_layoutType === 'sidebar_layout'"
  ></sidebar-layout>
  <top-navigation-layout
    v-if="themeStore.mainLayout_layoutType === 'top_navigation_layout'"
  ></top-navigation-layout>
  <theme-setting-form></theme-setting-form>
</template>

<script setup>
import SidebarLayout from "./main/SidebarLayout.vue";
import TopNavigationLayout from "./main/TopNavigationLayout.vue";
import ThemeSettingForm from "./main/ThemeSettingForm.vue";
import { useThemeStore } from "@/stores/theme";

const themeStore = useThemeStore();
</script>

<style lang="scss" scoped></style>
