import { createRouter, createWebHistory } from "vue-router";

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

export default router;
