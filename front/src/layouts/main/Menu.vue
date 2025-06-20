<template>
  <el-menu
    mode="vertical"
    text-color="rgba(255, 255, 255, 0.9)"
    active-text-color="#ffffff"
    :default-active="defaultActive"
    :collapse="mainLayoutStore.fold"
    :unique-opened="true"
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

<style lang="scss" scoped>
.menu {
  border-right: none;
  background-color: #141414;
  :deep(.el-menu) {
    background-color: #141414;
  }
  :deep(.el-sub-menu__title) {
    &:hover {
      background-color: #409eff;
    }
  }
  :deep(.el-menu-item) {
    &:hover {
      background-color: #409eff;
    }
  }
}
</style>
