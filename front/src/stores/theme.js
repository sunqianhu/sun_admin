import QuickNavigation from "@/layouts/main/QuickNavigation.vue";
import { defineStore } from "pinia";

//默认主题
const defaultTheme = {
  //全局
  leftWidth: 220,
  quickNavigation: true, //快捷导航栏

  //亮模式
  //侧边栏
  lightLeftBgColor: "#001e5f",
  lightLeftTextColor: "#ECF0F1",
  //菜单
  lightSystemMenuBgColor: "#001e5f",
  lightSystemMenuTextColor: "#ECF0F1",
  lightSystemMenuActiveBgColor: "#005ebf",
  lightSystemMenuActiveTextColor: "#ffffff",
  lightSystemMenuHoverBgColor: "#003e9f",
  lightSystemMenuHoverTextColor: "#ffffff",

  //---------------------
  //暗黑模式
  //侧边栏
  darkLeftBgColor: "#050404",
  darkLeftTextColor: "#dfdfdf",
  //菜单
  darkSystemMenuBgColor: "#050404",
  darkSystemMenuTextColor: "#dfdfdf",
  darkSystemMenuActiveBgColor: "#409eff",
  darkSystemMenuActiveTextColor: "#ffffff",
  darkSystemMenuHoverBgColor: "#409eff",
  darkSystemMenuHoverTextColor: "#ffffff",
};

/**
 * 从本地存储加载主题
 * @returns
 */
const loadFromStorage = () => {
  try {
    const saved = localStorage.getItem("theme_setting");
    if (saved) {
      const parsed = JSON.parse(saved);
      return { ...defaultTheme, ...parsed };
    }
  } catch (e) {
    console.warn("加载本地存储主题失败", e);
  }
  return { ...defaultTheme };
};

/**
 * 保存主题
 * @param {*} theme
 */
const saveToStorage = (theme) => {
  try {
    localStorage.setItem("theme_setting", JSON.stringify(theme));
  } catch (e) {
    console.warn("保存主题到本地存储失败", e);
  }
};

export const useThemeStore = defineStore("theme", {
  state: () => {
    return loadFromStorage();
  },
  actions: {
    /**
     * 更新全部
     * @param {*} localTheme
     */
    updateAll(localTheme) {
      Object.assign(this, localTheme);
      saveToStorage(this.$state);
    },

    /**
     * 恢复默认主题
     */
    resetToDefault() {
      Object.assign(this, defaultTheme);
      saveToStorage(this.$state);
    },
  },
});
