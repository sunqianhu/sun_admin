<template>
  <div class="index">
    <el-container :class="{ 'layout--fold': sideStore.fold }" class="layout">
      <el-aside class="layout__left">
        <div class="system-name-row">
          <img src="@/assets/logo.png" class="logo" />
          <span class="name">sun admin</span>
        </div>
        <el-scrollbar class="menu-row"><Menu></Menu></el-scrollbar>
        <div class="version">版本：{{ version }}</div>
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
            <light-dark class="header__light-dark"></light-dark>
            <avatar class="header__avatar"></avatar>
          </div>
        </el-header>
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
import { useSideStore } from "@/stores/layouts/side";
import Menu from "./Menu.vue";
import LightDark from "./LightDark.vue";
import Hamburger from "./Hamburger.vue";
import MessageNavigation from "./MessageNavigation.vue";
import FullScreen from "./FullScreen.vue";
import Avatar from "./Avatar.vue";
import Guide from "./Guide.vue";

const sideStore = useSideStore();
const version = import.meta.env.VITE_VERSION;

/**
 * 窗口大小改变回调
 */
window.onresize = () => {
  if (document.body.clientWidth < 768) {
    sideStore.setFold(true);
  }
};
</script>

<style lang="scss" scoped>
.index {
  height: 100dvh;
  > .layout {
    height: 100%;
    .layout__left {
      width: 220px;
      box-shadow: 2px 0 6px rgb(0 21 41 / 35%);
      background-color: #141414;
      color: #ffffff;
      z-index: 2;
      transition: width 0.5s;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      .system-name-row {
        width: 220px;
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
          font-weight: var(font-weight-bold);
          margin-left: 8px;
          display: inline-block;
          transition: all 0.5s;
        }
      }
      .menu-row {
        flex: 1;
      }
      .version {
        padding-left: var(--margin-sm);
        font-size: var(--font-size-sm);
        color: var(--font-color-secondary);
      }
    }

    .layout__right {
      background-color: var(--background-color);
      > .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 50px;
        background-color: #ffffff;
        box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
        padding: 0px;
        .header__right {
          display: flex;
          align-items: center;
          justify-content: flex-end;
          padding-right: var(--padding);
          .header__message-navigation,
          .header__fullscreen,
          .header__light-dark,
          .header__avatar {
            margin-left: var(--margin);
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

//暗黑模式
.dark {
  .layout {
    .layout__right {
      .header {
        background-color: #141414;
      }
    }
  }
}
</style>
