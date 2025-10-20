<template>
  <div class="main-layout">
    <el-container
      :class="{ 'layout--fold': mainLayoutStore.fold }"
      class="layout"
    >
      <el-aside class="layout__left">
        <div class="system-name-row">
          <img src="@/assets/logo.png" class="logo" />
          <span class="name">{{ systemName }}</span>
        </div>
        <el-scrollbar class="menu-row"><Menu></Menu></el-scrollbar>
      </el-aside>
      <el-container class="layout__right">
        <el-header class="header">
          <div class="header__left">
            <hamburger class="header__hamburger"></hamburger>
          </div>
          <div class="header__right">
            <message-navigation
              class="header__message-navigation"
            ></message-navigation>
            <full-screen class="header__fullscreen"></full-screen>
            <theme-setting class="header__theme-setting"></theme-setting>
            <light-dark class="header__light-dark"></light-dark>
            <avatar class="header__avatar"></avatar>
          </div>
        </el-header>
        <quick-navigation v-if="themeStore.quickNavigation"></quick-navigation>
        <el-main class="layout__workspace">
          <router-view v-slot="{ Component, route }">
            <keep-alive v-if="route.meta?.keep_alive">
              <component :is="Component" />
            </keep-alive>
            <component :is="Component" v-else />
          </router-view>
          <el-backtop :right="15" :bottom="15" target=".layout__workspace">
            UP
          </el-backtop>
        </el-main>
      </el-container>
    </el-container>
    <watermark />
    <popup-message />
    <guide />
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { useMainLayoutStore } from "@/stores/main_layout";
import axios from "@/helper/axios";
import Menu from "./main/Menu.vue";
import LightDark from "./main/LightDark.vue";
import Hamburger from "./main/Hamburger.vue";
import MessageNavigation from "./main/MessageNavigation.vue";
import FullScreen from "./main/FullScreen.vue";
import Avatar from "./main/Avatar.vue";
import Guide from "./main/Guide.vue";
import ThemeSetting from "./main/ThemeSetting.vue";
import QuickNavigation from "./main/QuickNavigation.vue";
import { useThemeStore } from "@/stores/theme";
import { useDark } from "@vueuse/core";

const mainLayoutStore = useMainLayoutStore();
const systemName = ref("");
const themeStore = useThemeStore();
const isDark = useDark();
const leftBgColor = computed(() =>
  isDark.value ? themeStore.darkLeftBgColor : themeStore.lightLeftBgColor
);
const leftTextColor = computed(() =>
  isDark.value ? themeStore.darkLeftTextColor : themeStore.lightLeftTextColor
);
const leftWidth = computed(() => themeStore.leftWidth);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/layouts.Main/init");
  if (response.code != 1) {
    return;
  }
  systemName.value = response.data.system_name;
};

/**
 * 窗口大小改变回调
 */
window.onresize = () => {
  if (document.body.clientWidth < 768) {
    mainLayoutStore.setFold(true);
  }
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.main-layout {
  position: absolute;
  left: 0;
  right: 0px;
  top: 0px;
  bottom: 0px;
  overflow: hidden;
  > .layout {
    height: 100%;
    position: relative;
    .layout__left {
      position: relative;
      z-index: 2;
      width: v-bind('leftWidth + "px"');
      box-shadow: 2px 0 6px rgb(0 21 41 / 35%);
      background-color: v-bind(leftBgColor);
      color: v-bind(leftTextColor);
      z-index: 2;
      transition: width 0.5s;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      .system-name-row {
        width: v-bind('leftWidth + "px"');
        height: 50px;
        line-height: 50px;
        overflow: hidden;
        transition: all 0.5s;
        padding-left: 19px;
        .logo {
          height: 25px;
          vertical-align: text-bottom;
        }
        .name {
          font-size: var(--font-size-xl);
          font-weight: var(--font-weight-bold);
          margin-left: 8px;
          display: inline-block;
          transition: all 0.5s;
        }
      }
      .menu-row {
        flex: 1;
      }
    }

    .layout__right {
      position: relative;
      z-index: 1;
      background-color: var(--background-color);
      > .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 50px;
        background-color: var(--background-color-light);
        padding: 0px;
        .header__right {
          display: flex;
          align-items: center;
          justify-content: flex-end;
          padding-right: var(--padding);
          .header__message-navigation,
          .header__fullscreen,
          .header__theme-setting,
          .header__light-dark,
          .header__avatar {
            margin-left: 24px;
          }
        }
      }
      .layout__workspace {
        padding: var(--padding);
      }
    }
    &.layout--fold {
      .layout__left {
        width: 64px;
        .system-name-row {
          padding-left: 19px;
          .name {
            margin-left: 30px;
          }
        }
        .version {
          display: none;
        }
      }
    }
  }

  @media (max-width: 768px) {
    .layout {
      &.layout--fold {
        .layout__left {
          width: 0px;
        }
      }
    }
  }
}
</style>
