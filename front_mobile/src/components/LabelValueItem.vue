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
  }
});
</script>

<style scoped lang="scss">
.col {
  display: flex;
  .label {
    white-space: nowrap;
    color: var(--font-color-secondary);
  }
  .value {
    flex: 1;
  }
}
</style>
