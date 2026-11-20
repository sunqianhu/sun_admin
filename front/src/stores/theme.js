import { defineStore } from "pinia";

//默认主题
const defaultTheme = {
  //主布局
  mainLayout_layoutType: "sidebar",
  mainLayout_quickNavigation: true,

  //侧边栏布局
  sidebar_leftWidth: 220,
  sidebar_light_leftBgColor: "#001e5f",
  sidebar_light_leftTextColor: "#ECF0F1",
  sidebar_light_menuBgColor: "#001e5f",
  sidebar_light_menuTextColor: "#ECF0F1",
  sidebar_light_menuActiveBgColor: "#005ebf",
  sidebar_light_menuActiveTextColor: "#ffffff",
  sidebar_light_menuHoverBgColor: "#003e9f",
  sidebar_light_menuHoverTextColor: "#ffffff",

  sidebar_dark_leftBgColor: "#050404",
  sidebar_dark_leftTextColor: "#dfdfdf",
  sidebar_dark_menuBgColor: "#050404",
  sidebar_dark_menuTextColor: "#dfdfdf",
  sidebar_dark_menuActiveBgColor: "#409eff",
  sidebar_dark_menuActiveTextColor: "#ffffff",
  sidebar_dark_menuHoverBgColor: "#409eff",
  sidebar_dark_menuHoverTextColor: "#ffffff",

  //顶部导航栏布局
  topNavigation_light_menuBgColor: "#001e5f",
  topNavigation_light_menuTextColor: "#ECF0F1",
  topNavigation_light_menuActiveBgColor: "#005ebf",
  topNavigation_light_menuActiveTextColor: "#ffffff",
  topNavigation_light_menuHoverBgColor: "#003e9f",
  topNavigation_light_menuHoverTextColor: "#ffffff",

  topNavigation_dark_menuBgColor: "#050404",
  topNavigation_dark_menuTextColor: "#dfdfdf",
  topNavigation_dark_menuActiveBgColor: "#409eff",
  topNavigation_dark_menuActiveTextColor: "#ffffff",
  topNavigation_dark_menuHoverBgColor: "#409eff",
  topNavigation_dark_menuHoverTextColor: "#ffffff",
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
