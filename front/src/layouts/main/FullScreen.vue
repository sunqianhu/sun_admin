<template>
  <div class="full-screen" @click="toggleFullScreen">
    <el-tooltip effect="dark" content="切换全屏" placement="bottom">
      <FullScreen class="full-screen__icon" />
    </el-tooltip>
  </div>
</template>

<script setup>
import { FullScreen } from "@element-plus/icons-vue";
import screenfull from "screenfull";

/**
 * 切换全屏
 */
const toggleFullScreen = () => {
  if (screenfull.isEnabled) {
    screenfull.toggle();
  } else {
    ElMessage({
      message: "你的浏览器不支持全屏",
      type: "error",
    });
  }
};
</script>

<style lang="scss" scoped>
.full-screen {
  line-height: 0px;
  .full-screen__icon {
    width: 20px;
    height: 20px;
    cursor: pointer;
    &:hover {
      opacity: var(--active-opacity);
    }
  }
}
</style>
