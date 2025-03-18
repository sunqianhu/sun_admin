<template>
  <div class="no-header-panel">
    <slot name="default"></slot>
  </div>
</template>

<script setup>
const props = defineProps({});
</script>

<style lang="scss" scoped>
.no-header-panel {
  background: var(--background-color-light);
  border-radius: var(--border-radius);
  padding: var(--padding);
}
</style>
