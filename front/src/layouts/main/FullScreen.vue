<template>
  <div class="full-screen" @click="toggleFullScreen">
    <el-tooltip effect="dark" content="切换全屏显示" placement="bottom">
      <el-icon class="icon"><FullScreen /></el-icon>
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
  cursor: pointer;
  .icon {
    font-size: 20px;
  }
  &:hover {
    .icon {
      animation: twinkle 0.3s ease-in-out;
    }
  }
}

@keyframes twinkle {
  0% {
    transform: scale(0);
  }
  80% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
  }
}
</style>
