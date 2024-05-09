import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/login",
      name: "login",
      component: () => import("../view/Login.vue"),
      meta: {
        name: "登录"
      }
    },
    {
      path: "/test",
      name: "test",
      component: () => import("../view/Test.vue"),
      meta: {
        name: "测试页面"
      }
    },
    {
      path: "/:pathMatch(.*)*",
      name: "404",
      component: () => import("../view/404.vue"),
      meta: {
        name: "页面没有找到"
      }
    }
  ]
});

export default router;
