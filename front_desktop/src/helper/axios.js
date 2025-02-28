import axios from "axios";
import router from "../router";
import { usePermissionStore } from "@/stores/permission";
import { useRouteStore } from "@/stores/route";

const instance = axios.create({
  baseURL: import.meta.env.VITE_API_PREFIX,
  timeout: 1000 * 60,
});

//请求拦截器
instance.interceptors.request.use(
  function (config) {
    //token
    let token = localStorage.getItem("token");
    if (token) {
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

  localStorage.removeItem("token");
  permissionStore.clear();
  routeStore.clear();
  router.replace("/login");
};

export default instance;
