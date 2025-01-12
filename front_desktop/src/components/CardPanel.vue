<template>
  <div class="card-panel">
    <slot name="header">
      <div
        class="card-panel__header"
        v-if="title || subTitle || $slots.actions"
      >
        <div class="card-panel__title" v-if="title">{{ title }}</div>
        <div class="card-panel__sub-title" v-if="subTitle">{{ subTitle }}</div>
        <div class="card-panel__actions" v-if="$slots.actions">
          <slot name="actions"></slot>
        </div>
      </div>
    </slot>
    <div class="card-panel__body">
      <slot name="default"></slot>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  title: {
    type: String,
    default: ""
  },
  subTitle: {
    type: String,
    default: ""
  }
});
</script>

<style lang="scss" scoped>
.card-panel {
  background: var(--background-color-light);
  border-radius: var(--border-radius-md);
  box-shadow: var(--box-shadow-base);
  .card-panel__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--padding-md) var(--padding-md) 0px var(--padding-md);
    .card-panel__title {
      color: var(--color-primary);
      position: relative;
      font-size: var(--font-size-lg);
      font-weight: var(font-weight-bold);
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
      margin-left: var(--margin-md);
      color: var(--font-color-secondary);
      font-size: var(--font-size-sm);
    }
    .card-panel__actions {
      margin-left: auto;
      margin-right: var(--margin-md);
    }
  }
  .card-panel__body {
    padding: var(--padding-md);
  }
}
</style>
