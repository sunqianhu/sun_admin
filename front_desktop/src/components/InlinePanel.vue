<template>
  <div class="inline-panel">
    <slot name="header">
      <div
        class="inline-panel__header"
        v-if="title || subTitle || $slots.actions"
      >
        <div class="inline-panel__title" v-if="title">{{ title }}</div>
        <div class="inline-panel__sub-title" v-if="subTitle">
          {{ subTitle }}
        </div>
        <div class="inline-panel__actions" v-if="$slots.actions">
          <slot name="actions"></slot>
        </div>
      </div>
    </slot>
    <div class="inline-panel__body">
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
.inline-panel {
  .inline-panel__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    .inline-panel__title {
      color: var(--color-primary);
      position: relative;
      font-size: var(--font-size-lg);
      font-weight: var(font-weight-bold);
      padding: var(--padding-md) var(--padding-md) 0px 0;
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
    .inline-panel__sub-title {
      flex: 1;
      margin-left: var(--margin-md);
      color: var(--font-color-secondary);
      font-size: var(--font-size-sm);
    }
    .inline-panel__actions {
      margin-left: auto;
      margin-right: var(--margin-md);
    }
  }
  .inline-panel__body {
    margin-top: var(--margin-md);
  }
}
</style>
