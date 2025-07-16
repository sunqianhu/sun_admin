<template>
  <div class="horizontal-loading">
    <div class="icon"></div>
    <div class="description"><slot name="default"></slot></div>
  </div>
</template>

<script setup>
const props = defineProps({
  size: {
    type: Number,
    default: 30,
  },
});
</script>

<style lang="scss" scoped>
.horizontal-loading {
  display: flex;
  align-items: center;
  .icon {
    width: 12px;
    height: 12px;
    border: 3px solid rgba(0, 0, 0, 0.1);
    border-top-color: #47aef3;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }
  .description {
    margin-left: 8px;
  }
}
@keyframes spin {
  100% {
    transform: rotate(360deg);
  }
}
</style>
