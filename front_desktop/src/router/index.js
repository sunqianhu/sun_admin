import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import "nprogress/nprogress.css";
import axios from "@/helper/axios";
import { usePermissionStore } from "@/stores/permission";
import { useRouteStore } from "@/stores/route";

const writeList = ["/login", "/404", "/test"];
const staticRoutes = [
  {
    path: "/",
    name: "side",
    component: () => import("../layouts/side/Index.vue"),
    meta: {
      name: "侧边布局"
    },
    children: []
  },
  {
    path: "/blank",
    name: "blank",
    component: () => import("../layouts/blank/Index.vue"),
    meta: {
      name: "空白布局"
    },
    children: []
  },
  {
    path: "/login",
    name: "login",
    component: () => import("../views/Login.vue"),
    meta: {
      name: "SunAdmin"
    }
  },
  {
    path: "/test",
    name: "test",
    component: () => import("../views/Test.vue"),
    meta: {
      name: "测试页面"
    }
  },
  {
    path: "/:pathMatch(.*)*",
    name: "404",
    component: () => import("../views/404.vue"),
    meta: {
      name: "没有找到页面"
    }
  }
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
    return "exist";
  }

  const response = await axios.get("desktop/frame/getPermissions");
  if (response.code != 1) {
    throw new Error(response.message);
  }
  permissionStore.set(response.data);

  return "complate";
};

/**
 * 设置路由
 * @param {*} to
 * @returns
 */
const setRoutes = async (path) => {
  const routeStore = useRouteStore();
  if (routeStore.isSet) {
    return "exist";
  }

  const response = await axios.get("desktop/frame/getRoutes");
  if (response.code != 1 || response.data.length == 0) {
    throw new Error(response.message);
  }
  routeStore.set(response.data);

  let sideRoute = staticRoutes.find((route) => route.name == "side");
  let blankRoute = staticRoutes.find((route) => route.name == "blank");
  let childRoutes = response.data;

  childRoutes.forEach((childRoute) => {
    if (!childRoute.component_path) {
      return;
    }
    childRoute.component = () => /* @vite-ignore */ import("../views/" + childRoute.component_path);

    if (childRoute.layout == "side") {
      sideRoute.children.push(childRoute);
    } else if (childRoute.layout == "blank") {
      blankRoute.children.push(childRoute);
    } else {
      router.addRoute(childRoute);
    }
  });

  //跳转
  if (sideRoute.children?.length > 0) {
    sideRoute.redirect = sideRoute.children[0].path;
  }

  router.addRoute(sideRoute);
  router.addRoute(blankRoute);

  return "complate";
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
    if (result == "complete") {
      return to.fullPath;
    }
  } catch (error) {
    return getLoginRoutePath();
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
  document.title = to.meta.name;
};

//路由对象
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: staticRoutes
});
router.beforeEach(beforeHandle);
router.afterEach(afterHandle);

export default router;
