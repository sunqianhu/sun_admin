<template>
  <div class="flag-title-panel">
    <div class="flag-title-panel__header">
      <div class="flag-title-panel__title">{{ title }}</div>
      <div class="flag-title-panel__sub-title">
        {{ subTitle }}
      </div>
      <div class="flag-title-panel__actions">
        <slot name="actions"></slot>
      </div>
    </div>
    <div class="flag-title-panel__body">
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
.flag-title-panel {
  .flag-title-panel__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    .flag-title-panel__title {
      position: relative;
      font-size: var(--font-size-lg);
      font-weight: var(--font-wieht-bold);
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
    .flag-title-panel__sub-title {
      flex: 1;
      margin-left: var(--margin-md);
      color: var(--font-color-secondary);
      font-size: var(--font-size-sm);
    }
    .flag-title-panel__actions {
      margin-left: auto;
    }
  }
  .flag-title-panel__body {
    margin-top: var(--margin-md);
  }
}
</style>
