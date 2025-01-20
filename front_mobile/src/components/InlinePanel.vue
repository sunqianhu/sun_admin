<template>
  <div class="panel-inline">
    <slot name="header">
      <div
        class="panel-inline__header"
        v-if="title || subTitle || $slots.actions"
      >
        <div class="panel-inline__title" v-if="title">{{ title }}</div>
        <div class="panel-inline__sub-title" v-if="subTitle">
          {{ subTitle }}
        </div>
        <div class="panel-inline__actions" v-if="$slots.actions">
          <slot name="actions"></slot>
        </div>
      </div>
    </slot>
    <div class="panel-inline__body">
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
.panel-inline {
  .panel-inline__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    .panel-inline__title {
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
    .panel-inline__sub-title {
      flex: 1;
      margin-left: var(--margin-md);
      color: var(--font-color-secondary);
      font-size: var(--font-size-sm);
    }
    .panel-inline__actions {
      margin-left: auto;
    }
  }
  .panel-inline__body {
    margin-top: var(--margin-md);
  }
}
</style>
