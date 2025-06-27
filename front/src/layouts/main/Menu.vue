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
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import { useMainLayoutStore } from "@/stores/main_layout";
import axios from "@/helper/axios";
import MenuItem from "./MenuItem.vue";

const mainLayoutStore = useMainLayoutStore();
const route = useRoute();
const defaultActive = route.fullPath; //默认活跃项
const treeMenu = ref([]);

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

<style lang="scss">
.main-menu-popper {
  --el-menu-text-color: #dfdfdf;
  --el-menu-bg-color: #141414;
  --el-menu-active-color: #ffffff;
  --el-menu-hover-bg-color: #409eff;
}
</style>

<style lang="scss" scoped>
.menu {
  --el-menu-text-color: #dfdfdf;
  --el-menu-bg-color: #050404;
  --el-menu-active-color: #ffffff;
  --el-menu-hover-bg-color: #409eff;
  border-right: none;
}
</style>
