import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import "nprogress/nprogress.css";

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
      path: "/login",
      name: "login",
      component: () => import("../views/Login.vue"),
      meta: {
        name: "登录"
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

  return true;
});

//后置钩子
router.afterEach((to, from) => {
  NProgress.done();
  document.title = to.meta.name;
});

export default router;
