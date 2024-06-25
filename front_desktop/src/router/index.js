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

//路由对象
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "main",
      component: () => import("../views/main/Index.vue"),
      meta: {
        name: "首页"
      },
      children: []
    },
    {
      path: "/blank",
      name: "blank",
      component: () => import("../views/blank/Index.vue"),
      meta: {
        name: "空白页面"
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
      path: "/system/desktop/permission",
      name: "system_desktop_permission",
      component: () => import("../views/system/desktop/permission/Index.vue"),
      meta: {
        name: "权限管理"
      }
    },
    {
      path: "/system/mobile/permission",
      name: "system_mobile_permission",
      component: () => import("../views/system/mobile/permission/Index.vue"),
      meta: {
        name: "权限管理"
      }
    },
    {
      path: "/system/desktop/menu",
      name: "system_desktop_menu",
      component: () => import("../views/system/desktop/menu/Index.vue"),
      meta: {
        name: "菜单管理"
      }
    },
    {
      path: "/system/desktop/route",
      name: "system_desktop_route",
      component: () => import("../views/system/desktop/route/Index.vue"),
      meta: {
        name: "菜单管理"
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

// //前置守卫
// router.beforeEach(async (to, from) => {
//   NProgress.start();

//   //白名单
//   const writeList = ["/login", "/404", "/test"];
//   if (writeList.includes(to.path)) {
//     return true;
//   }

//   //登录
//   const token = localStorage.getItem("token");
//   if (!token) {
//     return getLoginRoutePath();
//   }

//   const appStore = useAppStore();
//   let response; //响应

//   //权限
//   if (!appStore.isSetPermission) {
//     response = await axios.get("desktop/frame/getPermissions");
//     if (response.code != 1) {
//       return getLoginRoutePath();
//     }
//     appStore.setPermissions(response.data);
//   }

//   //动态路由
//   if (!appStore.isSetRoute) {
//     response = await axios.get("desktop/frame/getRoutes");
//     if (response.code != 1) {
//       return getLoginRoutePath();
//     }
//     appStore.setRoutes(response.data);

//     let allRoutes = router.getRoutes();
//     let mainRoute = allRoutes.find((route) => route.name == "main");
//     let blankRoute = allRoutes.find((route) => route.name == "blank");
//     let childRoutes = [];
//     const componentFilePaths = import.meta.glob([
//       "@/views/*.vue",
//       "@/views/*/*.vue",
//       "@/views/*/*/*.vue",
//       "@/views/*/*/*/*.vue"
//     ]);

//     if (response.data.length > 0) {
//       childRoutes = response.data;

//       childRoutes.forEach((childRoute) => {
//         childRoute.component = componentFilePaths["/src/views/" + childRoute.component];
//         if (childRoute.layout == "main") {
//           mainRoute.children.push(childRoute);
//           if (childRoute.parent_redirect) {
//             mainRoute.redirect = childRoute.path;
//           }
//         }
//         if (childRoute.layout == "blank") {
//           blankRoute.children.push(childRoute);
//           if (childRoute.parent_redirect) {
//             blankRoute.redirect = childRoute.path;
//           }
//         }
//       });

//       router.addRoute(mainRoute);
//       router.addRoute(blankRoute);
//     }

//     return to.fullPath;
//   }

//   return true;
// });

// //后置钩子
// router.afterEach((to, from) => {
//   NProgress.done();
//   document.title = to.meta.name;
// });

export default router;
