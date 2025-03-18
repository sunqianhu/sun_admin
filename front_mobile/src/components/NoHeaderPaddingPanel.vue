<template>
  <div class="no-header-padding-panel">
    <slot name="default"></slot>
  </div>
</template>

<script setup>
const props = defineProps({});
</script>

<style lang="scss" scoped>
.no-header-padding-panel {
  background: var(--background-color-light);
  border-radius: var(--border-radius);
}
</style>
