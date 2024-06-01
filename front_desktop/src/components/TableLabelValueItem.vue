<template></template>

<script setup>
const props = defineProps({
  label: {
    type: String,
    default: ""
  },
  labelWidth: {
    type: String,
    default: ""
  },
  labelColspan: {
    type: Number,
    default: 1
  },
  contentWidth: {
    type: String,
    default: ""
  },
  contentColspan: {
    type: Number,
    default: 1
  }
});
</script>

<style lang="scss" scoped></style>
