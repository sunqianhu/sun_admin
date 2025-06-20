import axios from "axios";
import router from "../router";
import { usePermissionStore } from "@/stores/permission";
import { useRouteStore } from "@/stores/route";
import routeCache from "@/helper/route_cache";
import permissionCache from "@/helper/permission_cache";
import watermarkCache from "@/helper/watermark_cache";

const instance = axios.create({
  baseURL: import.meta.env.VITE_API_PREFIX,
  timeout: 1000 * 30,
});

//请求拦截器
instance.interceptors.request.use(
  function (config) {
    //token
    let token = localStorage.getItem("token");
    if (token !== null) {
      config.headers.token = token;
    }
    return config;
  },
  function (error) {
    ElMessage({
      message: error.message,
      type: "error",
    });
    return Promise.reject(error);
  }
);

//响应拦截器
instance.interceptors.response.use(
  function (response) {
    const data = response.data;
    if (data && data.code == 2) {
      ElMessage({
        message: data.message,
        type: "error",
      });
      logout();
      return Promise.reject(data);
    }
    return data;
  },
  function (error) {
    let message =
      "状态码：" +
      error.status +
      "，错误码：" +
      error.code +
      "，错误描述：" +
      error.message +
      "，响应消息：" +
      error.response?.data?.message +
      "，请求网址：" +
      error.config?.url;
    ElMessage({
      message: message,
      type: "error",
    });
    return Promise.reject(error);
  }
);

/**
 * 退出登录
 */
const logout = () => {
  const permissionStore = usePermissionStore();
  const routeStore = useRouteStore();
  permissionStore.clear();
  routeStore.clear();

  localStorage.removeItem("token");

  permissionCache.clear();
  routeCache.clear();
  watermarkCache.clear();

  router.replace("/login");
};

export default instance;
