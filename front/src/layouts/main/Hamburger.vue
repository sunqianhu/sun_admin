<template>
  <div class="hamburger" @click="toggleFold">
    <el-tooltip effect="dark" content="折叠或展开侧边栏" placement="bottom">
      <component
        :is="mainLayoutStore.fold ? Expand : Fold"
        class="hamburger__icon"
      ></component>
    </el-tooltip>
  </div>
</template>

<script setup>
import { useMainLayoutStore } from "@/stores/main_layout.js";
import { Fold, Expand } from "@element-plus/icons-vue";

const mainLayoutStore = useMainLayoutStore();

/**
 * 切换折叠
 */
const toggleFold = () => {
  mainLayoutStore.toggleFold();
};
</script>

<style lang="scss" scoped>
.hamburger {
  height: 50px;
  width: 50px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  .hamburger__icon {
    width: 24px;
    height: 24px;
  }
  &:hover {
    background: rgba(0, 0, 0, 0.05);
    .hamburger__icon {
      opacity: var(--active-opacity);
    }
  }
}
</style>
