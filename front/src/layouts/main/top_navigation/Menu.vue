<template>
  <el-menu
    mode="horizontal"
    :ellipsis="false"
    :default-active="defaultActive"
    :unique-opened="true"
    popper-class="top-navigation-menu-popper"
    class="menu"
  >
    <menu-item :tree-menu="treeMenu"></menu-item>
  </el-menu>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { useRoute } from "vue-router";
import axios from "@/helper/axios";
import MenuItem from "./MenuItem.vue";
import { useThemeStore } from "@/stores/theme";
import { useDark } from "@vueuse/core";

const route = useRoute();
const defaultActive = computed(() => route.path); //默认活跃项
const treeMenu = ref([]);
const themeStore = useThemeStore();
const isDark = useDark();

const menuBgColor = computed(() =>
  isDark.value
    ? themeStore.topNavigation_dark_menuBgColor
    : themeStore.topNavigation_light_menuBgColor,
);
const menuTextColor = computed(() =>
  isDark.value
    ? themeStore.topNavigation_dark_menuTextColor
    : themeStore.topNavigation_light_menuTextColor,
);
const menuActiveBgColor = computed(() =>
  isDark.value
    ? themeStore.topNavigation_dark_menuActiveBgColor
    : themeStore.topNavigation_light_menuActiveBgColor,
);
const menuActiveTextColor = computed(() =>
  isDark.value
    ? themeStore.topNavigation_dark_menuActiveTextColor
    : themeStore.topNavigation_light_menuActiveTextColor,
);
const menuHoverBgColor = computed(() =>
  isDark.value
    ? themeStore.topNavigation_dark_menuHoverBgColor
    : themeStore.topNavigation_light_menuHoverBgColor,
);
const menuHoverTextColor = computed(() =>
  isDark.value
    ? themeStore.topNavigation_dark_menuHoverTextColor
    : themeStore.topNavigation_light_menuHoverTextColor,
);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/layouts.main.top_navigation.Menu/getTreeMenu",
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
  --el-menu-active-bg-color: v-bind(menuActiveBgColor);
  --el-menu-active-color: v-bind(menuActiveTextColor);
  --el-menu-hover-bg-color: v-bind(menuHoverBgColor);
  --el-menu-hover-text-color: v-bind(menuHoverTextColor);
  border-bottom: none;

  :deep(.el-menu-item.is-active) {
    background-color: v-bind(menuActiveBgColor);
    border-bottom: none;
  }
  :deep(.el-sub-menu) {
    .el-sub-menu__title {
      border-bottom: none !important;
    }
  }
  :deep(.el-sub-menu.is-active) {
    .el-sub-menu__title {
      background-color: v-bind(menuActiveBgColor);
    }
  }
}
</style>
