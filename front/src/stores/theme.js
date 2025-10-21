import { defineStore } from "pinia";

//默认主题
const defaultTheme = {
  //主布局
  mainLayout_layoutType: "sidebar_layout",
  mainLayout_quickNavigation: true,

  //侧边栏布局
  sidebarLayout_leftWidth: 220,
  sidebarLayout_light_leftBgColor: "#001e5f",
  sidebarLayout_light_leftTextColor: "#ECF0F1",
  sidebarLayout_light_menuBgColor: "#001e5f",
  sidebarLayout_light_menuTextColor: "#ECF0F1",
  sidebarLayout_light_menuActiveBgColor: "#005ebf",
  sidebarLayout_light_menuActiveTextColor: "#ffffff",
  sidebarLayout_light_menuHoverBgColor: "#003e9f",
  sidebarLayout_light_menuHoverTextColor: "#ffffff",

  sidebarLayout_dark_leftBgColor: "#050404",
  sidebarLayout_dark_leftTextColor: "#dfdfdf",
  sidebarLayout_dark_menuBgColor: "#050404",
  sidebarLayout_dark_menuTextColor: "#dfdfdf",
  sidebarLayout_dark_menuActiveBgColor: "#409eff",
  sidebarLayout_dark_menuActiveTextColor: "#ffffff",
  sidebarLayout_dark_menuHoverBgColor: "#409eff",
  sidebarLayout_dark_menuHoverTextColor: "#ffffff",

  //顶部导航栏布局
  topNavigationLayout_light_menuBgColor: "#001e5f",
  topNavigationLayout_light_menuTextColor: "#ECF0F1",
  topNavigationLayout_light_menuActiveBgColor: "#005ebf",
  topNavigationLayout_light_menuActiveTextColor: "#ffffff",
  topNavigationLayout_light_menuHoverBgColor: "#003e9f",
  topNavigationLayout_light_menuHoverTextColor: "#ffffff",

  topNavigationLayout_dark_menuBgColor: "#050404",
  topNavigationLayout_dark_menuTextColor: "#dfdfdf",
  topNavigationLayout_dark_menuActiveBgColor: "#409eff",
  topNavigationLayout_dark_menuActiveTextColor: "#ffffff",
  topNavigationLayout_dark_menuHoverBgColor: "#409eff",
  topNavigationLayout_dark_menuHoverTextColor: "#ffffff",
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
     * 更新属性
     * @param {*} attribute
     * @param {*} value
     */
    setAttribute(attribute, value) {
      this[attribute] = value;
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
