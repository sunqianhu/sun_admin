<template>
  <el-col
    :span="props.span"
    :xs="props.xs"
    :sm="props.sm"
    :md="props.md"
    :lg="props.lg"
    class="label-value-item"
  >
    <div class="label-value-item__label">{{ label }}：</div>
    <div class="label-value-item__value"><slot></slot></div>
  </el-col>
</template>

<script setup>
const props = defineProps({
  label: {
    type: String,
    default: "",
  },
});
</script>

<style scoped lang="scss">
.label-value-item {
  display: flex;
  .label-value-item__label {
    white-space: nowrap;
    color: var(--font-color-secondary);
  }
  .label-value-item__value {
    flex: 1;
  }
}
</style>
