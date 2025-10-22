<template></template>

<script setup>
import { onMounted } from "vue";
import { driver } from "driver.js";
import "driver.js/dist/driver.css";
import { useThemeStore } from "@/stores/theme";

const themeStore = useThemeStore();

/**
 * 引导
 */
const guide = () => {
  if (localStorage.getItem("guide") == "1") {
    return;
  }

  localStorage.setItem("guide", 1);
  let steps = [
    {
      element: ".sidebar-layout__left",
      popover: {
        title: "功能菜单",
        description: "点击功能菜单导航到具体的功能页面",
      },
    },
    {
      element: ".header__hamburger",
      popover: { title: "折叠按钮", description: "打开或折叠左边功能菜单" },
    },
    {
      element: ".header__message-navigation",
      popover: {
        title: "系统消息",
        description: "查看历史系统消息",
      },
    },
    {
      element: ".header__fullscreen",
      popover: { title: "全屏", description: "切换全屏显示" },
    },
    {
      element: ".header__theme-setting",
      popover: { title: "主题设置", description: "设置系统主题" },
    },
    {
      element: ".header__light-dark",
      popover: {
        title: "暗黑模式",
        description: "晚上浏览可切换到暗黑模式，保护眼睛",
      },
    },
    {
      element: ".header__avatar",
      popover: { title: "头像", description: "查看或修改个人信息" },
    },
  ];
  if (themeStore.mainLayout_quickNavigation) {
    steps.push({
      element: ".sidebar-layout__quick-navigation",
      popover: {
        title: "快捷导航",
        description: "点击快捷导航快速打开功能页面",
      },
    });
  }
  steps.push({
    element: ".sidebar-layout__workspace",
    popover: { title: "工作区", description: "具体功能显示区" },
  });

  const driverObj = driver({
    showProgress: true,
    steps: steps,
    prevBtnText: "上一个",
    nextBtnText: "下一个",
    doneBtnText: "完成",
  });
  driverObj.drive();
};

onMounted(() => {
  guide();
});
</script>

<style lang="scss" scoped></style>
