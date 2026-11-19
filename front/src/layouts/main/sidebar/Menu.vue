<template>
  <el-menu
    mode="vertical"
    :default-active="defaultActive"
    :collapse="sidebarStore.fold"
    :unique-opened="true"
    popper-class="main-menu-popper"
    class="menu"
  >
    <menu-item :tree-menu="treeMenu"></menu-item>
  </el-menu>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { useRoute } from "vue-router";
import { useSidebarStore } from "@/stores/layout/sidebar";
import axios from "@/helper/axios";
import MenuItem from "./MenuItem.vue";
import { useThemeStore } from "@/stores/theme";
import { useDark } from "@vueuse/core";

const sidebarStore = useSidebarStore();
const route = useRoute();
const defaultActive = computed(() => route.path); //默认活跃项
const treeMenu = ref([]);
const themeStore = useThemeStore();
const isDark = useDark();

const menuBgColor = computed(() =>
  isDark.value
    ? themeStore.sidebar_dark_menuBgColor
    : themeStore.sidebar_light_menuBgColor
);
const menuTextColor = computed(() =>
  isDark.value
    ? themeStore.sidebar_dark_menuTextColor
    : themeStore.sidebar_light_menuTextColor
);
const menuActiveBgColor = computed(() =>
  isDark.value
    ? themeStore.sidebar_dark_menuActiveBgColor
    : themeStore.sidebar_light_menuActiveBgColor
);
const menuActiveTextColor = computed(() =>
  isDark.value
    ? themeStore.sidebar_dark_menuActiveTextColor
    : themeStore.sidebar_light_menuActiveTextColor
);
const menuHoverBgColor = computed(() =>
  isDark.value
    ? themeStore.sidebar_dark_menuHoverBgColor
    : themeStore.sidebar_light_menuHoverBgColor
);
const menuHoverTextColor = computed(() =>
  isDark.value
    ? themeStore.sidebar_dark_menuHoverTextColor
    : themeStore.sidebar_light_menuHoverTextColor
);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/layouts.main.sidebar.Menu/getTreeMenu"
  );
  treeMenu.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.menu {
  --el-menu-bg-color: v-bind(menuBgColor);
  --el-menu-text-color: v-bind(menuTextColor);
  --el-menu-active-color: v-bind(menuActiveTextColor);
  --el-menu-hover-bg-color: v-bind(menuHoverBgColor);
  --el-menu-hover-text-color: v-bind(menuHoverTextColor);
  border-right: none;

  :deep(.el-menu-item.is-active) {
    background-color: v-bind(menuActiveBgColor);
  }
}
</style>
