<template>
  <div class="sidebar">
    <el-container
      :class="{ 'sidebar--fold': sidebarStore.fold }"
      class="sidebar__container"
    >
      <el-aside class="sidebar__left">
        <div class="system-name-row" v-if="systemName !== ''">
          <img
            :src="systemLogoUrl"
            class="logo"
            alt="系统Logo"
            v-if="systemLogoUrl !== ''"
          />
          <div class="system-info">
            <span class="name">{{ systemName }}</span>
            <span class="version">版本：{{ version }}</span>
          </div>
        </div>
        <el-scrollbar class="menu-row"><Menu></Menu></el-scrollbar>
      </el-aside>
      <el-container class="sidebar__right">
        <el-header class="header">
          <div class="header__left">
            <hamburger class="header__hamburger"></hamburger>
          </div>
          <quick-navigation
            class="header__center quick-navigation"
            v-if="themeStore.mainLayout_quickNavigation"
          ></quick-navigation>
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
        <el-main class="sidebar__workspace">
          <router-view v-slot="{ Component, route }">
            <keep-alive v-if="route.meta?.keep_alive">
              <component :is="Component" />
            </keep-alive>
            <component :is="Component" v-else />
          </router-view>
          <el-backtop :right="15" :bottom="15" target=".sidebar__workspace">
            UP
          </el-backtop>
        </el-main>
      </el-container>
    </el-container>
    <guide />
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { useSidebarStore } from "@/stores/layout/sidebar";
import axios from "@/helper/axios";
import { useThemeStore } from "@/stores/theme";
import { useDark } from "@vueuse/core";
import Menu from "./sidebar/Menu.vue";
import LightDark from "./LightDark.vue";
import Hamburger from "./Hamburger.vue";
import MessageNavigation from "./MessageNavigation.vue";
import FullScreen from "./FullScreen.vue";
import Avatar from "./Avatar.vue";
import Guide from "./sidebar/Guide.vue";
import ThemeSetting from "./ThemeSetting.vue";
import QuickNavigation from "./QuickNavigation.vue";

const sidebarStore = useSidebarStore();
const systemName = ref("");
const systemLogoUrl = ref("");
const version = ref("");
const themeStore = useThemeStore();
const isDark = useDark();
const leftBgColor = computed(() =>
  isDark.value
    ? themeStore.sidebar_dark_leftBgColor
    : themeStore.sidebar_light_leftBgColor,
);
const leftTextColor = computed(() =>
  isDark.value
    ? themeStore.sidebar_dark_leftTextColor
    : themeStore.sidebar_light_leftTextColor,
);
const leftWidth = computed(() => themeStore.sidebar_leftWidth);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/layouts.main.Sidebar/init");
  if (response.code != 0) {
    return;
  }
  systemName.value = response.data.system_name;
  systemLogoUrl.value = response.data.system_logo_url;
  version.value = response.data.version;
};

/**
 * 窗口大小改变回调
 */
window.onresize = () => {
  if (document.body.clientWidth < 768) {
    sidebarStore.setFold(true);
  }
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.sidebar {
  position: absolute;
  left: 0;
  right: 0px;
  top: 0px;
  bottom: 0px;
  overflow: hidden;
  > .sidebar__container {
    height: 100%;
    position: relative;
    .sidebar__left {
      position: relative;
      width: v-bind('leftWidth + "px"');
      background-color: v-bind(leftBgColor);
      color: v-bind(leftTextColor);
      transition: width 0.5s;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      padding-bottom: var(--padding);
      .system-name-row {
        width: v-bind('leftWidth + "px"');
        flex-shrink: 0;
        display: flex;
        overflow: hidden;
        transition: all 0.5s;
        padding-left: 10px;
        padding-top: 8px;
        .logo {
          width: 32px;
          height: 32px;
          object-fit: contain;
          flex-shrink: 0;
          padding-top: 6px;
        }
        .system-info {
          display: flex;
          flex-direction: column;
          margin-left: 8px;
          line-height: 1.2;
          transition: margin-left 0.5s;
          .name {
            font-size: var(--font-size-xl);
            font-weight: var(--font-weight-bold);
            white-space: nowrap;
          }
          .version {
            font-size: var(--font-size-sm);
            opacity: 0.5;
          }
        }
      }
      .menu-row {
        margin-top: var(--margin);
        flex: 1;
        min-height: 0;
      }
    }

    .sidebar__right {
      position: relative;
      min-width: 0;
      > .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 50px;
        background-color: var(--background-color-layout-main-header);
        padding: 0px;
        .header__center {
          flex: 1;
          min-width: 0;
          overflow: hidden;
          border-top: none;
          --el-tabs-header-height: 50px;
          margin-left: var(--margin);
          :deep(.el-tabs__header) {
            border-bottom: none;
            .el-tabs__nav-prev,
            .el-tabs__nav-next {
              height: 50px;
              display: flex;
              align-items: center;
              justify-content: center;
            }
          }
        }
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
      .sidebar__workspace {
        padding: var(--padding);
      }
    }
    &.sidebar--fold {
      .sidebar__left {
        width: 64px;
        .system-name-row {
          padding-left: 13px;
          .system-info {
            margin-left: 50px;
          }
        }
      }
    }
  }

  @media (max-width: 768px) {
    .sidebar__container {
      .sidebar__right > .header .header__center {
        display: none;
      }
      &.sidebar--fold {
        .sidebar__left {
          width: 0px;
        }
      }
    }
  }
}
</style>
