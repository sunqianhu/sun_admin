<template>
  <div class="card-fields">
    <slot name="default"></slot>
  </div>
</template>

<script setup></script>

<style lang="scss" scoped>
.card-fields {
  background: var(--background-color-light);
  border-radius: var(--border-radius-md);
  box-shadow: var(--box-shadow-base);
  overflow: hidden;
}
</style>
