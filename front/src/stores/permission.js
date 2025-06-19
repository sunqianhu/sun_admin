import { defineStore } from "pinia";

export const usePermissionStore = defineStore("permission", {
  state: () => {
    return {
      isSet: false,
      permissions: [], //权限
    };
  },
  actions: {
    /**
     * 设置
     * @param {array} permissions 权限数组
     */
    set(permissions) {
      this.isSet = true;
      this.permissions = [...permissions];
    },

    /**
     * 清除
     */
    clear() {
      this.isSet = false;
      this.permissions = [];
    },
  },
});
