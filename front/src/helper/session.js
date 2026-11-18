import router from "@/router";
import { usePermissionStore } from "@/stores/permission";
import { useRouteStore } from "@/stores/route";
import routeCache from "@/helper/route_cache";
import permissionCache from "@/helper/permission_cache";
import watermarkCache from "@/helper/watermark_cache";

/**
 * 登录
 * @param {string} token 会话令牌
 */
export const login = (token) => {
  localStorage.setItem("token", token);
  location.replace("./");
};

/**
 * 退出登录
 */
export const logout = () => {
  const permissionStore = usePermissionStore();
  permissionStore.clear();

  const routeStore = useRouteStore();
  routeStore.clear();

  localStorage.removeItem("token");

  permissionCache.clear();
  routeCache.clear();
  watermarkCache.clear();

  router.replace("/login");
};
