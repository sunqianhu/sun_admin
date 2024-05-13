import { useAppStore } from "../stores/app";

class Permission {
  /**
   * 是否拥有权限
   * @param {*} key
   * @returns
   */
  hasPermission(key) {
    const appStore = useAppStore();
    const permissions = appStore.permissions;
    if (!permissions.includes(key)) {
      return false;
    }

    return true;
  }
}

export default Permission;
