<template></template>

<script setup>
import { onMounted } from "vue";
import { driver } from "driver.js";
import "driver.js/dist/driver.css";

/**
 * 引导
 */
const guide = () => {
  if (localStorage.getItem("guide") == "1") {
    return;
  }

  localStorage.setItem("guide", 1);
  const driverObj = driver({
    showProgress: true,
    steps: [
      {
        element: ".aside",
        popover: { title: "功能菜单", description: "点击功能菜单导航到具体的功能栏目" }
      },
      {
        element: ".hamburger",
        popover: { title: "折叠按钮", description: "打开或折叠左边功能菜单" }
      },
      {
        element: ".light-dark",
        popover: { title: "暗黑模式", description: "晚上浏览可切换到暗黑模式，保护眼睛" }
      },
      { element: ".fullscreen", popover: { title: "全屏", description: "切换全屏显示" } },
      { element: ".avatar", popover: { title: "头像", description: "查看修改个人信息" } },
      { element: ".body", popover: { title: "工作区", description: "具体功能显示区" } }
    ],
    prevBtnText: "上一个",
    nextBtnText: "下一个",
    doneBtnText: "完成"
  });
  driverObj.drive();
};

onMounted(() => {
  guide();
});
</script>

<style lang="scss" scoped></style>
