<template>
  <div class="theme-setting">
    <el-tooltip effect="dark" content="设置系统主题" placement="bottom">
      <el-icon class="icon" @click="openForm"><Setting /></el-icon>
    </el-tooltip>
  </div>
</template>

<script setup>
import { Setting } from "@element-plus/icons-vue";
import { useThemeSettingFormStore } from "@/stores/theme_setting_form";

const themeSettingFormStore = useThemeSettingFormStore();

/**
 * 打开表单
 */
const openForm = () => {
  themeSettingFormStore.openFlag = true;
};
</script>

<style lang="scss" scoped>
.theme-setting {
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
