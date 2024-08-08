import { usePermissionStore } from "@/stores/permission";

/**
 * 是否拥有权限
 * @param {*} key
 * @returns
 */
export const hasPermission = (key) => {
  const permissionStore = usePermissionStore();
  const permissions = permissionStore.permissions;
  if (!permissions) {
    return false;
  }
  return permissions.includes(key);
};
