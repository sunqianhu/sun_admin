import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import "nprogress/nprogress.css";
import axios from "@/helper/axios";
import { usePermissionStore } from "@/stores/permission";
import { useRouteStore } from "@/stores/route";
import routeCache from "@/helper/route_cache";
import permissionCache from "@/helper/permission_cache";

const writeList = ["/login", "/404", "/test"];
const staticRoutes = [
  {
    path: "/",
    name: "main",
    component: () => import("../layouts/Main.vue"),
    meta: {
      name: "主布局",
    },
    children: [],
  },
  {
    path: "/blank",
    name: "blank",
    component: () => import("../layouts/Blank.vue"),
    meta: {
      name: "空白布局",
    },
    children: [],
  },
  {
    path: "/login",
    name: "login",
    component: () => import("../views/Login.vue"),
    meta: {
      name: "sun admin",
    },
  },
  {
    path: "/test",
    name: "test",
    component: () => import("../views/Test.vue"),
    meta: {
      name: "测试页面",
    },
  },
  {
    path: "/:pathMatch(.*)*",
    name: "404",
    component: () => import("../views/404.vue"),
    meta: {
      name: "没有找到页面",
    },
  },
];

/**
 * 得到登录路由路径
 * @returns
 */
const getLoginRoutePath = () => {
  return "/login";
};

/**
 * 设置权限
 * @returns
 */
const setPermissions = async () => {
  const permissionStore = usePermissionStore();
  if (permissionStore.isSet) {
    return;
  }
  let permissions = permissionCache.get();
  if (!permissions) {
    const response = await axios.get("desktop/frame/getPermissions");
    if (response.code != 1) {
      throw new Error(response.message);
    }
    permissions = response.data;
    permissionCache.set(permissions);
  }
  permissionStore.set(permissions);
};

/**
 * 设置路由
 * @returns
 */
const setRoutes = async () => {
  const routeStore = useRouteStore();
  if (routeStore.isSet) {
    return "exist";
  }

  let childRoutes = routeCache.get();
  if (!childRoutes) {
    const response = await axios.get("desktop/frame/getRoutes");
    if (response.code != 1) {
      throw new Error(response.message);
    }
    childRoutes = response.data;
    routeCache.set(childRoutes);
  }
  routeStore.set(childRoutes);

  let mainRoute = staticRoutes.find((route) => route.name == "main");
  let blankRoute = staticRoutes.find((route) => route.name == "blank");
  const componentFilePaths = import.meta.glob([
    "@/views/*.vue",
    "@/views/*/*.vue",
    "@/views/*/*/*.vue",
    "@/views/*/*/*/*.vue",
  ]);

  for (const childRoute of childRoutes) {
    if (!childRoute.component_path) {
      continue;
    }
    childRoute.component =
      componentFilePaths["/src/views/" + childRoute.component_path];
    if (!childRoute.component) {
      console.error("没有找到组件路径：" + childRoute.component_path);
      continue;
    }

    if (childRoute.layout == "main") {
      mainRoute.children.push(childRoute);
    } else if (childRoute.layout == "blank") {
      blankRoute.children.push(childRoute);
    } else {
      router.addRoute(childRoute);
    }
  }

  //系统消息
  let messageRoute = {
    path: "/system/message",
    name: "system_message",
    component: () => import("../views/system/message/Index.vue"),
    meta: {
      name: "系统消息",
    },
  };
  mainRoute.children.push(messageRoute);

  router.addRoute(mainRoute);
  router.addRoute(blankRoute);

  return "load";
};

/**
 * 得到主布局跳转子路由
 * @param {*} currentRoutePath
 * @returns
 */
const getMainRouteRedirect = (currentRoutePath) => {
  if (currentRoutePath !== "/") {
    return null;
  }
  let mainRoute = staticRoutes.find((route) => route.name == "main");
  if (!mainRoute.children?.length) {
    return null;
  }
  let path = mainRoute.children[0]?.path;
  if (path === "") {
    return null;
  }
  return { path: path, replace: true };
};

/**
 * 路由前置守卫处理
 * @param {*} to
 * @param {*} from
 * @returns
 */
const beforeHandle = async (to, from) => {
  NProgress.start();

  //白名单
  if (writeList.includes(to.path)) {
    return true;
  }

  //登录
  const token = localStorage.getItem("token");
  if (!token) {
    return getLoginRoutePath();
  }

  //权限+路由
  try {
    await setPermissions();
    let result = await setRoutes();
    if (result === "load") {
      return to.fullPath;
    }
  } catch (error) {
    console.error(error);
    return getLoginRoutePath();
  }

  //跳转
  let redirect = getMainRouteRedirect(to.path);
  if (redirect) {
    return redirect;
  }

  return true;
};

/**
 * 路由后置守卫处理
 * @param {*} to
 * @param {*} from
 */
const afterHandle = (to, from) => {
  NProgress.done();
  document.title = to.meta.name || "sun admin";
};

//路由对象
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: staticRoutes,
});
router.beforeEach(beforeHandle);
router.afterEach(afterHandle);

export default router;
