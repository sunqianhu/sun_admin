<template>
  <el-menu
    mode="vertical"
    text-color="rgba(255, 255, 255, 0.9)"
    active-text-color="#ffffff"
    :default-active="defaultActive"
    :collapse="sideStore.fold"
    :unique-opened="true"
    class="menu"
  >
    <menu-item :menus="menus"></menu-item>
  </el-menu>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import { useSideStore } from "@/stores/layouts/side";
import axios from "@/helper/axios";
import MenuItem from "./MenuItem.vue";

const sideStore = useSideStore();
const route = useRoute();
const defaultActive = route.fullPath; //默认活跃项
const menus = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/layouts.Side/getMenus");
  menus.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.menu {
  border-right: none;
}
</style>
