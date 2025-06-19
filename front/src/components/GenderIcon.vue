<template>
  <span class="gander" :title="name">
    <el-icon v-if="id == 0" class="gander__man"><UserFilled /></el-icon>
    <el-icon v-if="id == 1" class="gander__woman"><Avatar /></el-icon>
  </span>
</template>

<script setup>
import { UserFilled, Avatar } from "@element-plus/icons-vue";
const props = defineProps({
  id: {
    type: Number,
    default: 0,
  },
  name: {
    type: String,
    default: "",
  },
});
</script>

<style lang="scss" scoped>
.gander {
  vertical-align: middle;
  .gander__man {
    color: #409eff;
  }
  .gander__woman {
    color: #ff007d;
  }
}
</style>
