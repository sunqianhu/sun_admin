<template>
  <div class="flag-title-panel">
    <div class="flag-title-panel__header">
      <div class="flag-title-panel__title-col">
        <div class="flag-title-panel__title">{{ title }}</div>
        <div class="flag-title-panel__sub-title">
          {{ subTitle }}
        </div>
      </div>
      <div class="flag-title-panel__action-col">
        <slot name="action"></slot>
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
    .flag-title-panel__title-col {
      display: flex;
      align-items: center;
      .flag-title-panel__title {
        position: relative;
        font-size: var(--font-size-lg);
        font-weight: var(--font-weight-bold);
        display: flex;
        align-items: center;
        &::before {
          content: "";
          display: inline-block;
          vertical-align: -2px;
          width: 5px;
          height: 20px;
          background-color: var(--color-primary);
          margin-right: 8px;
          border-radius: 2px;
        }
      }
      .flag-title-panel__sub-title {
        flex: 1;
        margin-left: var(--margin);
        color: var(--font-color-secondary);
      }
    }
    .flag-title-panel__action-col {
    }
  }
  .flag-title-panel__body {
    margin-top: var(--margin-sm);
  }
}
</style>
