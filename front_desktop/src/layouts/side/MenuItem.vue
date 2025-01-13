<template>
  <template v-for="menu in treeMenu" :key="menu.id">
    <template v-if="!menu.children">
      <el-menu-item
        :index="menu.url"
        @click="navigateTo(menu.url, menu.target)"
      >
        <el-icon v-if="menu.icon">
          <component :is="icons[menu.icon]"></component>
        </el-icon>
        <span>{{ menu.name }}</span>
      </el-menu-item>
    </template>
    <el-sub-menu :index="'group_' + menu.id" v-else>
      <template #title>
        <el-icon v-if="menu.icon">
          <component :is="icons[menu.icon]"></component>
        </el-icon>
        <span>{{ menu.name }}</span>
      </template>
      <menu-item :tree-menu="menu.children"></menu-item>
    </el-sub-menu>
  </template>
</template>

<script setup>
import * as icons from "@element-plus/icons-vue";
import { useRouter } from "vue-router";

const router = useRouter();
const props = defineProps({
  treeMenu: {
    type: Array,
    default: [],
  },
});

/**
 * 导航
 * @param url
 * @param target
 */
const navigateTo = (url, target) => {
  if (target == 9) {
    window.open(url);
    return;
  }
  router.push(url);
};
</script>

<style lang="scss" scoped>
.el-menu-item.is-active {
  background-color: #409eff;
}
</style>
