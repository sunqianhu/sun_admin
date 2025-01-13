import { defineStore } from "pinia";

export const useRouteStore = defineStore("route", {
  state: () => {
    return {
      isSet: false,
      routes: [],
    };
  },
  actions: {
    /**
     * 设置
     * @param {array} routes 路由数组
     */
    set(routes) {
      this.isSet = true;
      this.routes = routes;
    },

    /**
     * 清除
     */
    clear() {
      this.isSet = false;
      this.routes = [];
    },
  },
});
