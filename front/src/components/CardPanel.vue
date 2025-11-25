<template>
  <div class="card-panel">
    <div class="card-panel__header">
      <div class="card-panel__title">{{ title }}</div>
      <div class="card-panel__sub-title">{{ subTitle }}</div>
      <div class="card-panel__action">
        <slot name="action"></slot>
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
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  padding: var(--padding);
  position: relative;

  .card-panel__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    .card-panel__title {
      color: var(--color-primary);
      position: relative;
      font-size: var(--font-size-lg);
      font-weight: var(--font-weight-bold);
      &::before {
        content: "";
        display: inline-block;
        vertical-align: -3px;
        width: 4px;
        height: 18px;
        background-color: var(--color-primary);
        margin-right: var(--margin-sm);
        border-radius: 2px;
      }
    }
    .card-panel__sub-title {
      flex: 1;
      margin-left: var(--margin);
      color: var(--font-color-secondary);
      font-size: var(--font-size-sm);
    }
    .card-panel__action {
      margin-left: auto;
      margin-right: var(--margin);
    }
  }
  .card-panel__body {
    margin-top: var(--margin);
  }
}
</style>
