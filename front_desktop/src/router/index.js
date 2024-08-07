import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import "nprogress/nprogress.css";
import axios from "@/helper/axios";
import { useAppStore } from "@/stores/app";

const writeList = ["/login", "/404", "/test"];
const routeConfig = [
  {
    path: "/",
    name: "side",
    component: () => import("../layouts/side/Index.vue"),
    meta: {
      name: "主布局"
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
  const appStore = useAppStore();
  if (appStore.isSetPermission) {
    return true;
  }

  const response = await axios.get("desktop/frame/getPermissions");
  if (response.code != 1) {
    return getLoginRoutePath();
  }
  appStore.setPermissions(response.data);

  return true;
};

/**
 * 设置布局路由
 * @param {*} to
 * @returns
 */
const setLayoutRoutes = async (path) => {
  const appStore = useAppStore();
  if (appStore.isSetRoute) {
    return true;
  }

  const response = await axios.get("desktop/frame/getRoutes");
  if (response.code != 1) {
    return getLoginRoutePath();
  }
  if (response.data.length == 0) {
    return getLoginRoutePath();
  }
  appStore.setRoutes(response.data);

  let routes = router.getRoutes();
  let sideRoute = routes.find((route) => route.name == "side");
  let blankRoute = routes.find((route) => route.name == "blank");
  const components = import.meta.glob([
    "@/views/*.vue",
    "@/views/*/*.vue",
    "@/views/*/*/*.vue",
    "@/views/*/*/*/*.vue"
  ]);

  let childRoutes = response.data;
  childRoutes.forEach((childRoute) => {
    if (!childRoute.component_path) {
      return;
    }
    childRoute.component = components["/src/views/" + childRoute.component_path];
    if (childRoute.layout == "side") {
      sideRoute.children.push(childRoute);
    } else if (childRoute.layout == "blank") {
      blankRoute.children.push(childRoute);
    }
  });

  if (sideRoute.children?.length > 0) {
    sideRoute.redirect = sideRoute.children[0].path;
  }

  router.addRoute(sideRoute);
  router.addRoute(blankRoute);

  return path;
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

  //权限
  let result = await setPermissions();
  if (result !== true) {
    return result;
  }

  //动态路由
  result = await setLayoutRoutes(to.path);
  if (result !== true) {
    return result;
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
  routes: routeConfig
});
router.beforeEach(beforeHandle);
router.afterEach(afterHandle);

export default router;
