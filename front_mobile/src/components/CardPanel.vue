<template>
  <div class="card-panel">
    <div class="card-panel__header">
      <div class="card-panel__title">{{ title }}</div>
      <div class="card-panel__sub-title">{{ subTitle }}</div>
      <div class="card-panel__actions">
        <slot name="actions"></slot>
      </div>
    </div>
    <div class="card-panel__body">
      <slot name="default"></slot>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  title: {
    type: String,
    default: "",
  },
  subTitle: {
    type: String,
    default: "",
  },
});
</script>

<style lang="scss" scoped>
.card-panel {
  background: var(--background-color-light);
  border-radius: var(--border-radius-md);
  padding: var(--padding-md);
  .card-panel__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    .card-panel__title {
      font-size: var(--font-size-lg);
      font-weight: var(--font-weight-bold);
    }
    .card-panel__actions {
      margin-left: auto;
      margin-right: var(--margin-md);
    }
  }
  .card-panel__body {
    margin-top: var(--margin-md);
  }
}
</style>
