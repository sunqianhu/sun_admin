<template>
  <el-tabs
    v-model="quickNavigationStore.active"
    type="card"
    tab-position="top"
    :stretch="false"
    :closable="quickNavigationStore.quickNavigations?.length > 1"
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
import { useRoute, useRouter } from "vue-router";
import { useQuickNavigationStore } from "../../stores/quick_navigation";

const route = useRoute();
const router = useRouter();
const quickNavigationStore = useQuickNavigationStore();

/**
 * 导航
 * @param key
 */
const navigation = (key) => {
  const quickNavigation = quickNavigationStore.quickNavigations.find(
    (item) => item.key === key,
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
    const isCurrentRoute = router.currentRoute.value.name === key;
    quickNavigationStore.remove(key);
    if (isCurrentRoute) {
      const lastQuickNavigation = quickNavigationStore.quickNavigations.find(
        (item) => item.key === quickNavigationStore.active,
      );
      if (lastQuickNavigation) {
        router.push({ path: lastQuickNavigation.path });
      }
    }
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
  --el-tabs-header-height: 40px;
  background-color: var(--background-color-light);
  :deep(.el-tabs__content) {
    display: none;
  }
  :deep(.el-tabs__header) {
    margin-bottom: 0px;
    border-bottom: none;
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
