<template>
  <div class="panel-card">
    <slot name="header">
      <div class="header" v-if="title || subTitle || $slots.actions">
        <div class="title" v-if="title">{{ title }}</div>
        <div class="sub-title" v-if="subTitle">{{ subTitle }}</div>
        <div class="actions" v-if="$slots.actions">
          <slot name="actions"></slot>
        </div>
      </div>
    </slot>
    <div class="body">
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
.panel-card {
  background: var(--background-color-light);
  border-radius: var(--border-radius-md);
  box-shadow: var(--box-shadow-base);
  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--padding-md) var(--padding-md) 0px var(--padding-md);
    .title {
      color: var(--color-primary);
      position: relative;
      font-size: var(--font-size-lg);
      font-weight: bold;
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
    .sub-title {
      flex: 1;
      margin-left: var(--margin-md);
      color: var(--font-color-secondary);
      font-size: var(--font-size-sm);
    }
    .actions {
      margin-left: auto;
      margin-right: var(--margin-md);
    }
  }
  .body {
    padding: var(--padding-md);
  }
}
</style>
