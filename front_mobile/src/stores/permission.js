import { defineStore } from "pinia";

export const useAppStore = defineStore("app", {
  state: () => ({
    isSetPermission: false, //是否设置权限
    permissions: [] //权限
  }),
  actions: {
    /**
     * 设置权限
     * @param {array} permissions 权限数组
     */
    setPermissions(permissions) {
      this.isSetPermission = true;
      this.permissions = permissions;
    },

    /**
     * 清除权限
     */
    clearPermissions() {
      this.isSetPermission = false;
      this.permissions = [];
    }
  }
});
