import { defineStore } from "pinia";

export const useThemeSettingFormStore = defineStore("theme_setting_form", {
  state: () => {
    return {
      openFlag: false,
    };
  },
  actions: {
    /**
     * 设置
     * @param {array} routes 路由数组
     */
    open() {
      this.openFlag = true;
    },

    /**
     * 关闭
     */
    close() {
      this.openFlag = false;
    },
  },
});
