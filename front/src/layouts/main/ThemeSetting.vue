<template>
  <div class="theme-setting">
    <el-tooltip effect="dark" content="界面主题设置" placement="bottom">
      <el-icon class="icon" @click="openSetting"><Setting /></el-icon>
    </el-tooltip>
    <el-drawer
      v-model="settingFlag"
      title="主题设置"
      direction="rtl"
      size="300px"
      @close="closeSetting"
    >
      <el-form :model="themeForm" scroll-to-error>
        <el-form-item label="暗黑模式" prop="type">
          <el-switch v-model="isDark" @change="useToggle" />
        </el-form-item>

        <el-divider content-position="center">侧边栏</el-divider>
        <template v-if="!isDark">
          <el-form-item label="侧边栏背景颜色" prop="darkLeftBgColor">
            <el-color-picker
              v-model="themeForm.lightLeftBgColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item label="侧边栏文字颜色" prop="darkLeftTextColor">
            <el-color-picker
              v-model="themeForm.lightLeftTextColor"
              @change="updateAll"
            />
          </el-form-item>
        </template>
        <template v-else>
          <el-form-item label="侧边栏背景颜色" prop="darkLeftBgColor">
            <el-color-picker
              v-model="themeForm.darkLeftBgColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item label="侧边栏文字颜色" prop="darkLeftTextColor">
            <el-color-picker
              v-model="themeForm.darkLeftTextColor"
              @change="updateAll"
            />
          </el-form-item>
        </template>
        <el-form-item label="系统菜单栏宽度" prop="type">
          <el-input-number
            v-model="themeForm.leftWidth"
            :min="150"
            :max="400"
            @change="updateAll"
          />
        </el-form-item>

        <el-divider content-position="center">系统菜单</el-divider>
        <template v-if="!isDark">
          <el-form-item
            label="系统菜单栏背景颜色"
            prop="lightSystemMenuBgColor"
          >
            <el-color-picker
              v-model="themeForm.lightSystemMenuBgColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏文字颜色"
            prop="lightSystemMenuTextColor"
          >
            <el-color-picker
              v-model="themeForm.lightSystemMenuTextColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏激活项背景颜色"
            prop="lightSystemMenuActiveBgColor"
          >
            <el-color-picker
              v-model="themeForm.lightSystemMenuActiveBgColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏激活项文字颜色"
            prop="lightSystemMenuActiveTextColor"
          >
            <el-color-picker
              v-model="themeForm.lightSystemMenuActiveTextColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏鼠标经过项背景颜色"
            prop="lightSystemMenuActiveTextColor"
          >
            <el-color-picker
              v-model="themeForm.lightSystemMenuHoverBgColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏鼠标经过项文字颜色"
            prop="lightSystemMenuActiveTextColor"
          >
            <el-color-picker
              v-model="themeForm.lightSystemMenuHoverTextColor"
              @change="updateAll"
            />
          </el-form-item>
        </template>
        <template v-else>
          <el-form-item label="系统菜单栏背景颜色" prop="darkSystemMenuBgColor">
            <el-color-picker
              v-model="themeForm.darkSystemMenuBgColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏文字颜色"
            prop="darkSystemMenuTextColor"
          >
            <el-color-picker
              v-model="themeForm.darkSystemMenuTextColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏激活项背景颜色"
            prop="darkSystemMenuActiveBgColor"
          >
            <el-color-picker
              v-model="themeForm.darkSystemMenuActiveBgColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏激活项文字颜色"
            prop="darkSystemMenuActiveTextColor"
          >
            <el-color-picker
              v-model="themeForm.darkSystemMenuActiveTextColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏鼠标经过项背景颜色"
            prop="darkSystemMenuActiveTextColor"
          >
            <el-color-picker
              v-model="themeForm.darkSystemMenuHoverBgColor"
              @change="updateAll"
            />
          </el-form-item>
          <el-form-item
            label="系统菜单栏鼠标经过项文字颜色"
            prop="darkSystemMenuActiveTextColor"
          >
            <el-color-picker
              v-model="themeForm.darkSystemMenuHoverTextColor"
              @change="updateAll"
            />
          </el-form-item>
        </template>
        <!--暗黑模式-->

        <el-form-item>
          <el-button style="width: 100%" @click="resetToDefault"
            >恢复默认</el-button
          >
        </el-form-item>
      </el-form>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { Setting } from "@element-plus/icons-vue";
import { useDark, useToggle } from "@vueuse/core";
import { useThemeStore } from "@/stores/theme";

const isDark = useDark();
const settingFlag = ref(false);
const theme = useThemeStore();

const themeForm = ref({ ...theme });
themeForm.value.isDark = isDark.value;

/**
 * 打开设置
 */
const openSetting = () => {
  settingFlag.value = true;
};

/**
 * 关闭设置
 */
const closeSetting = () => {
  settingFlag.value = false;
};

/**
 * 更新主题
 */
const updateAll = () => {
  theme.updateAll(themeForm.value);
};

/**
 * 恢复默认
 */
const resetToDefault = () => {
  theme.resetToDefault();
  ElMessage({
    message: "恢复成功",
    type: "success",
  });
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
