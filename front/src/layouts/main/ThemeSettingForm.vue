<template>
  <el-drawer
    v-model="themeSettingFormStore.openFlag"
    title="主题设置"
    direction="rtl"
    size="310px"
    class="theme-setting-form"
    @close="close"
  >
    <el-form :model="theme" scroll-to-error class="form">
      <el-form-item label="暗黑模式" prop="isDark">
        <el-switch v-model="isDark" @change="useToggle" />
      </el-form-item>

      <el-divider content-position="center">主布局</el-divider>
      <el-form-item label="布局方式" prop="mainLayout_layoutType">
        <div class="select-layout-type">
          <el-row>
            <el-col :span="12">
              <img
                src="@/assets/main/sidebar_layout_icon.png"
                class="select-layout-type__icon"
                :class="{
                  'select-layout-type__icon--selected':
                    theme.mainLayout_layoutType === 'sidebar_layout',
                }"
                @click="selectLayoutType('sidebar_layout')"
              />
            </el-col>
            <el-col :span="12">
              <img
                src="@/assets/main/top_navigation_layout_icon.png"
                class="select-layout-type__icon"
                :class="{
                  'select-layout-type__icon--selected':
                    theme.mainLayout_layoutType === 'top_navigation_layout',
                }"
                @click="selectLayoutType('top_navigation_layout')"
              />
            </el-col>
          </el-row>
        </div>
      </el-form-item>
      <el-form-item label="快捷导航栏" prop="mainLayout_quickNavigation">
        <el-switch
          v-model="theme.mainLayout_quickNavigation"
          @change="
            (value) => {
              setAttribute('mainLayout_quickNavigation', value);
            }
          "
        />
      </el-form-item>

      <el-divider content-position="center">侧边栏布局</el-divider>
      <el-form-item label="宽度" prop="sidebarLayout_leftWidth">
        <el-input-number
          v-model="theme.sidebarLayout_leftWidth"
          :min="200"
          :max="500"
          @change="
            (value) => {
              setAttribute('sidebarLayout_leftWidth', value);
            }
          "
        />
      </el-form-item>
      <template v-if="!isDark">
        <el-form-item label="背景颜色" prop="sidebarLayout_light_leftBgColor">
          <el-color-picker
            v-model="theme.sidebarLayout_light_leftBgColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_light_leftBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item label="文字颜色" prop="sidebarLayout_light_leftTextColor">
          <el-color-picker
            v-model="theme.sidebarLayout_light_leftTextColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_light_leftTextColor', value);
              }
            "
          />
        </el-form-item>

        <el-form-item
          label="菜单背景颜色"
          prop="sidebarLayout_light_menuBgColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_light_menuBgColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_light_menuBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单文字颜色"
          prop="sidebarLayout_light_menuTextColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_light_menuTextColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_light_menuTextColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单激活项背景颜色"
          prop="sidebarLayout_light_menuActiveBgColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_light_menuActiveBgColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_light_menuActiveBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单激活项文字颜色"
          prop="sidebarLayout_light_menuActiveTextColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_light_menuActiveTextColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_light_menuActiveTextColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单鼠标经过项背景颜色"
          prop="sidebarLayout_light_menuHoverBgColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_light_menuHoverBgColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_light_menuHoverBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单鼠标经过项文字颜色"
          prop="sidebarLayout_light_menuHoverTextColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_light_menuHoverTextColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_light_menuHoverTextColor', value);
              }
            "
          />
        </el-form-item>
      </template>
      <template v-else>
        <el-form-item label="背景颜色" prop="sidebarLayout_dark_leftBgColor">
          <el-color-picker
            v-model="theme.sidebarLayout_dark_leftBgColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_dark_leftBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item label="文字颜色" prop="sidebarLayout_dark_leftTextColor">
          <el-color-picker
            v-model="theme.sidebarLayout_dark_leftTextColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_dark_leftTextColor', value);
              }
            "
          />
        </el-form-item>

        <el-form-item
          label="菜单背景颜色"
          prop="sidebarLayout_dark_menuBgColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_dark_menuBgColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_dark_menuBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单文字颜色"
          prop="sidebarLayout_dark_menuTextColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_dark_menuTextColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_dark_menuTextColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单激活项背景颜色"
          prop="sidebarLayout_dark_menuActiveBgColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_dark_menuActiveBgColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_dark_menuActiveBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单激活项文字颜色"
          prop="sidebarLayout_dark_menuActiveTextColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_dark_menuActiveTextColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_dark_menuActiveTextColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单鼠标经过项背景颜色"
          prop="sidebarLayout_dark_menuHoverBgColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_dark_menuHoverBgColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_dark_menuHoverBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单鼠标经过项文字颜色"
          prop="sidebarLayout_dark_menuHoverTextColor"
        >
          <el-color-picker
            v-model="theme.sidebarLayout_dark_menuHoverTextColor"
            @change="
              (value) => {
                setAttribute('sidebarLayout_dark_menuHoverTextColor', value);
              }
            "
          />
        </el-form-item>
      </template>

      <el-divider content-position="center">顶部导航布局</el-divider>
      <template v-if="!isDark">
        <el-form-item
          label="菜单背景颜色"
          prop="topNavigationLayout_light_menuBgColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_light_menuBgColor"
            @change="
              (value) => {
                setAttribute('topNavigationLayout_light_menuBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单文字颜色"
          prop="topNavigationLayout_light_menuTextColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_light_menuTextColor"
            @change="
              (value) => {
                setAttribute('topNavigationLayout_light_menuTextColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单激活项背景颜色"
          prop="topNavigationLayout_light_menuActiveBgColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_light_menuActiveBgColor"
            @change="
              (value) => {
                setAttribute(
                  'topNavigationLayout_light_menuActiveBgColor',
                  value
                );
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单激活项文字颜色"
          prop="topNavigationLayout_light_menuActiveTextColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_light_menuActiveTextColor"
            @change="
              (value) => {
                setAttribute(
                  'topNavigationLayout_light_menuActiveTextColor',
                  value
                );
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单鼠标经过项背景颜色"
          prop="topNavigationLayout_light_menuHoverBgColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_light_menuHoverBgColor"
            @change="
              (value) => {
                setAttribute(
                  'topNavigationLayout_light_menuHoverBgColor',
                  value
                );
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单鼠标经过项文字颜色"
          prop="topNavigationLayout_light_menuHoverTextColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_light_menuHoverTextColor"
            @change="
              (value) => {
                setAttribute(
                  'topNavigationLayout_light_menuHoverTextColor',
                  value
                );
              }
            "
          />
        </el-form-item>
      </template>
      <template v-else>
        <el-form-item
          label="菜单背景颜色"
          prop="topNavigationLayout_dark_menuBgColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_dark_menuBgColor"
            @change="
              (value) => {
                setAttribute('topNavigationLayout_dark_menuBgColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单文字颜色"
          prop="topNavigationLayout_dark_menuTextColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_dark_menuTextColor"
            @change="
              (value) => {
                setAttribute('topNavigationLayout_dark_menuTextColor', value);
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单激活项背景颜色"
          prop="topNavigationLayout_dark_menuActiveBgColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_dark_menuActiveBgColor"
            @change="
              (value) => {
                setAttribute(
                  'topNavigationLayout_dark_menuActiveBgColor',
                  value
                );
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单激活项文字颜色"
          prop="topNavigationLayout_dark_menuActiveTextColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_dark_menuActiveTextColor"
            @change="
              (value) => {
                setAttribute(
                  'topNavigationLayout_dark_menuActiveTextColor',
                  value
                );
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单鼠标经过项背景颜色"
          prop="topNavigationLayout_dark_menuHoverBgColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_dark_menuHoverBgColor"
            @change="
              (value) => {
                setAttribute(
                  'topNavigationLayout_dark_menuHoverBgColor',
                  value
                );
              }
            "
          />
        </el-form-item>
        <el-form-item
          label="菜单鼠标经过项文字颜色"
          prop="topNavigationLayout_dark_menuHoverTextColor"
        >
          <el-color-picker
            v-model="theme.topNavigationLayout_dark_menuHoverTextColor"
            @change="
              (value) => {
                setAttribute(
                  'topNavigationLayout_dark_menuHoverTextColor',
                  value
                );
              }
            "
          />
        </el-form-item>
      </template>

      <el-form-item>
        <el-button style="width: 100%" @click="resetToDefault">
          恢复默认
        </el-button>
      </el-form-item>
    </el-form>
  </el-drawer>
</template>

<script setup>
import { ref } from "vue";
import { useDark, useToggle } from "@vueuse/core";
import { useThemeStore } from "@/stores/theme";
import { useThemeSettingFormStore } from "@/stores/theme_setting_form";

const isDark = useDark();
const themeStore = useThemeStore();
const themeSettingFormStore = useThemeSettingFormStore();

const theme = ref({ ...themeStore });
theme.value.isDark = isDark.value;

/**
 * 关闭
 */
const close = () => {
  themeStore.themeSetting_formFlag = false;
};

/**
 * 更新属性
 */
const setAttribute = (attribute, value) => {
  try {
    themeStore.setAttribute(attribute, value);
  } catch (e) {
    ElMessage({
      message: e.message,
      type: "error",
    });
  }
};

/**
 * 选择布局类型
 */
const selectLayoutType = (value) => {
  theme.value.mainLayout_layoutType = value;
  setAttribute("mainLayout_layoutType", value);
};

/**
 * 恢复默认
 */
const resetToDefault = () => {
  themeStore.resetToDefault();
  theme.value = { ...themeStore };
  ElMessage({
    message: "恢复成功",
    type: "success",
  });
};
</script>

<style lang="scss" scoped>
:deep(.theme-setting-form) {
  .el-drawer__header {
    margin-bottom: var(--margin);
  }
}
.theme-setting-form {
  .select-layout-type {
    .select-layout-type__icon {
      width: 80px;
      border: 1px solid transparent;
      cursor: pointer;
      margin-right: var(--margin-sm);
      &:hover {
        border-color: #409eff;
      }
    }
    .select-layout-type__icon--selected {
      border-color: #409eff;
    }
  }
}
</style>
