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
    padding: var(--padding-sm) var(--padding-md) 0px var(--padding-md);
    .title {
      position: relative;
      font-size: var(--font-size-lg);
      font-weight: bold;
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
