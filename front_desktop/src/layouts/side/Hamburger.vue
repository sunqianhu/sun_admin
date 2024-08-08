<template>
  <div class="hamburger" @click="toggleFold">
    <component :is="sideStore.fold ? Expand : Fold" class="icon"></component>
  </div>
</template>

<script setup>
import { useSideStore } from "@/stores/layouts/side.js";
import { Fold, Expand } from "@element-plus/icons-vue";

const sideStore = useSideStore();

/**
 * 切换折叠
 */
const toggleFold = () => {
  sideStore.toggleFold();
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
  .icon {
    width: 25px;
    height: 25px;
  }
  &:hover {
    background: rgba(0, 0, 0, 0.025);
    .icon {
      opacity: var(--opacity);
    }
  }
}
</style>
