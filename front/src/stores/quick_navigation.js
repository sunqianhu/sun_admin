import { defineStore } from "pinia";

export const useQuickNavigationStore = defineStore("quick_navigation", {
  state: () => ({
    quickNavigations: [],
    active: "",
  }),
  actions: {
    /**
     * 更新或插入
     * @param {*} route
     * @returns
     */
    upsert(route) {
      const { name, path, meta } = route;
      if (!meta?.name || meta?.layout !== "main") {
        return;
      }
      const label = meta.name;
      const index = this.quickNavigations.findIndex(
        (item) => item.key === name
      );

      if (index >= 0) {
        this.quickNavigations[index].key = name;
        this.quickNavigations[index].label = label;
        this.quickNavigations[index].path = path;
      } else {
        this.quickNavigations.push({ key: name, label, path: path });
      }

      this.active = name;
    },

    /**
     * 删除
     * @param {*} key
     * @returns
     */
    remove(key) {
      if (this.quickNavigations.length <= 1) {
        throw new Error("最后一页不能删除");
      }

      let quickNavigations = this.quickNavigations;
      const quickNavigation = quickNavigations.find((item) => item.key === key);
      if (!quickNavigation) {
        throw new Error("未找到快捷导航");
      }

      //删除
      quickNavigations = quickNavigations.filter((item) => item.key !== key);
      this.quickNavigations = quickNavigations;

      //更新当前页
      if (quickNavigation.key === this.active) {
        let length = quickNavigations.length;
        let lastQuickNavigation = quickNavigations[length - 1];
        this.active = lastQuickNavigation.key;
      }
    },
  },
});
