import { defineStore } from "pinia";

export const useSidebarStore = defineStore("sidebar", {
  state: () => {
    return {
      fold: false,
    };
  },
  actions: {
    /**
     * 切换折叠
     */
    toggleFold() {
      this.fold = this.fold ? false : true;
      let value = this.fold ? "1" : "0";
      localStorage.setItem("layout_side_fold", value);
    },

    /**
     * 设置折叠
     * @param {boolean} status
     */
    setFold(status) {
      this.fold = status;
      let value = this.fold ? "1" : "0";
      localStorage.setItem("layout_side_fold", value);
    },
  },
});
