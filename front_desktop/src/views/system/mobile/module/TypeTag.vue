<template>
  <el-tag :type="type">
    <slot></slot>
  </el-tag>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
const props = defineProps({
  id: {
    type: Number,
    default: 0
  }
});

const type = ref("");

/**
 * 初始化
 */
const init = () => {
  let id = props.id;
  switch (id) {
    case 1:
      type.value = "primary";
      break;
    case 2:
      type.value = "success";
      break;
    case 3:
      type.value = "info";
      break;
    case 4:
      type.value = "warning";
      break;
    case 5:
      type.value = "danger";
      break;
    default:
      type.value = "primary";
      break;
  }
};

/**
 * 侦听props
 */
watch(
  () => props.id,
  (newNumber) => {
    init();
  },
  {
    deep: true
  }
);

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
