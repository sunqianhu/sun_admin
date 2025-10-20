<template>
  <el-tabs
    v-model="quickNavigationStore.active"
    type="card"
    tab-position="top"
    :stretch="false"
    closable
    class="quick-navigation"
    @update:model-value="navigation"
    @tab-remove="remove"
  >
    <el-tab-pane
      v-for="quickNavigation in quickNavigationStore.quickNavigations"
      :name="quickNavigation.key"
      :label="quickNavigation.label"
    />
  </el-tabs>
</template>

<script setup>
import { useRouter } from "vue-router";
import { useQuickNavigationStore } from "../../stores/quick_navigation";

const router = useRouter();
const quickNavigationStore = useQuickNavigationStore();

/**
 * 导航
 * @param key
 */
const navigation = (key) => {
  const quickNavigation = quickNavigationStore.quickNavigations.find(
    (item) => item.key === key
  );
  if (quickNavigation && router.currentRoute.value.name !== key) {
    router.push({ path: quickNavigation.path });
  }
};

/**
 * 关闭
 * @param key
 */
const remove = (key) => {
  try {
    quickNavigationStore.remove(key);
  } catch (error) {
    ElMessage({
      message: error.message,
      type: "error",
    });
  }
};
</script>

<style lang="scss" scoped>
.quick-navigation {
  --el-tabs-header-height: 32px;
  background-color: var(--background-color-light);
  border-top: 1px solid var(--border-color);
  //box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
  :deep(.el-tabs__content) {
    display: none;
  }
  :deep(.el-tabs__header) {
    margin-bottom: 0px;
    .el-tabs__nav-prev,
    .el-tabs__nav-next {
      line-height: 34px;
    }
    .el-tabs__nav {
      border: none;
      .el-tabs__item {
        border: none;
      }
      .is-active {
        background-color: var(--background-color);
      }
    }
  }
}
</style>
