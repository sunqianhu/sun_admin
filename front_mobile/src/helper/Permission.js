import { useAppStore } from "../stores/app";

/**
 * 是否拥有权限
 * @param {*} key
 * @returns
 */
export const hasPermission = (key) => {
  const appStore = useAppStore();
  const permissions = appStore.permissions;
  if (!permissions.includes(key)) {
    return false;
  }

  return true;
};
