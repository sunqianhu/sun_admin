import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import "nprogress/nprogress.css";
import axios from "@/helper/axios";
import { useAppStore } from "@/stores/app";

/**
 * 得到登录路由路径
 * @returns
 */
const getLoginRoutePath = () => {
  return "/login";
};

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "index",
      component: () => import("../views/Index.vue"),
      meta: {
        name: "首页"
      },
      children: []
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/Login.vue"),
      meta: {
        name: "登录"
      }
    },
    {
      path: "/my/detail",
      name: "my_detail",
      component: () => import("../views/my/Detail.vue"),
      meta: {
        name: "个人信息"
      },
      children: []
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
        name: "页面没有找到"
      }
    }
  ]
});

const writeList = ["/login", "/404", "/test"];

//前置守卫
router.beforeEach(async (to, from) => {
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

  const appStore = useAppStore();
  let response; //响应

  //权限
  if (!appStore.isSetPermission) {
    response = await axios.get("mobile/Frame/getPermissions");
    if (response.code != 1) {
      return getLoginRoutePath();
    }
    appStore.setPermissions(response.data);
  }

  return true;
});

//后置钩子
router.afterEach((to, from) => {
  NProgress.done();
  document.title = to.meta.name;
});

export default router;
