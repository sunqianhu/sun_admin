<template>
  <el-col :xs="props.xs" :sm="props.sm" :md="props.md" :lg="props.lg" class="col">
    <div class="label">{{ label }}：</div>
    <div class="value"><slot></slot></div>
  </el-col>
</template>

<script setup>
const props = defineProps({
  label: {
    type: String,
    default: ""
  },
  xs: {
    type: Number,
    default: 24
  },
  sm: {
    type: Number,
    default: 12
  },
  md: {
    type: Number,
    default: 8
  },
  lg: {
    type: Number,
    default: 6
  }
});
</script>

<style scoped lang="scss">
.col {
  display: flex;
  .label {
    color: var(--font-color-secondary);
  }
  .value {
    flex: 1;
  }
}
</style>
