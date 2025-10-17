<template>
  <el-menu
    mode="vertical"
    :default-active="defaultActive"
    :collapse="mainLayoutStore.fold"
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
import { useMainLayoutStore } from "@/stores/main_layout";
import axios from "@/helper/axios";
import MenuItem from "./MenuItem.vue";
import { useThemeStore } from "@/stores/theme";
import { useDark } from "@vueuse/core";

const mainLayoutStore = useMainLayoutStore();
const route = useRoute();
const defaultActive = route.fullPath; //默认活跃项
const treeMenu = ref([]);
const theme = useThemeStore();
const isDark = useDark();

const menuBgColor = computed(() =>
  isDark.value ? theme.darkSystemMenuBgColor : theme.lightSystemMenuBgColor
);
const menuTextColor = computed(() =>
  isDark.value ? theme.darkSystemMenuTextColor : theme.lightSystemMenuTextColor
);
const menuActiveTextColor = computed(() =>
  isDark.value
    ? theme.darkSystemMenuActiveTextColor
    : theme.lightSystemMenuActiveTextColor
);
const menuHoverBgColor = computed(() =>
  isDark.value
    ? theme.darkSystemMenuHoverBgColor
    : theme.lightSystemMenuHoverBgColor
);
const menuHoverTextColor = computed(() =>
  isDark.value
    ? theme.darkSystemMenuHoverTextColor
    : theme.lightSystemMenuHoverTextColor
);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/layouts.main.Menu/getTreeMenu");
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

  :deep(.el-sub-menu__title:hover),
  :deep(.el-menu-item:hover) {
    color: v-bind(menuHoverTextColor) !important;
  }
  :deep(.el-menu-item.is-active) {
    color: v-bind(menuActiveTextColor) !important;
  }

  border-right: none;
}
</style>
