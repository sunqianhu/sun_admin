<template>
  <el-col
    :span="props.span"
    :xs="props.xs"
    :sm="props.sm"
    :md="props.md"
    :lg="props.lg"
    class="attribute"
  >
    <div class="attribute__label">{{ label }}：</div>
    <div class="attribute__value"><slot></slot></div>
  </el-col>
</template>

<script setup>
const props = defineProps({
  label: {
    type: String,
    default: "",
  },
  span: {
    type: Number,
    default: 8,
  },
});
</script>

<style scoped lang="scss">
.attribute {
  display: flex;
  padding: 4px;
  .attribute__label {
    white-space: nowrap;
    color: var(--font-color-secondary);
  }
  .attribute__value {
    flex: 1;
  }
}
</style>
