<template>
  <div class="side-layout">
    <el-container
      :class="{ 'side-layout__container--fold': sideStore.fold }"
      class="side-layout__container"
    >
      <el-aside class="side-layout__aside">
        <div class="system-name">
          <img src="@/assets/logo.png" class="system-name__logo" />
          <span class="system-name__name">SunAdmin</span>
        </div>
        <el-scrollbar class="menu-wrap"><Menu></Menu></el-scrollbar>
        <div class="version">版本：{{ version }}</div>
      </el-aside>
      <el-container class="side-layout__workspace">
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
        <el-main class="body">
          <router-view v-slot="{ Component, route }">
            <keep-alive v-if="route.meta?.keep_alive">
              <component :is="Component" />
            </keep-alive>
            <component :is="Component" v-else />
          </router-view>
          <el-backtop
            :right="15"
            :bottom="15"
            target=".side-layout__workspace .body"
          >
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
.side-layout {
  height: 100dvh;
  .side-layout__container {
    height: 100%;
    .side-layout__aside {
      width: 220px;
      box-shadow: 2px 0 6px rgb(0 21 41 / 35%);
      background-color: #141414;
      color: #ffffff;
      z-index: 2;
      transition: width 0.5s;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      .system-name {
        width: 220px;
        height: 50px;
        line-height: 50px;
        overflow: hidden;
        transition: all 0.5s;
        padding-left: 19px;
        .system-name__logo {
          height: 25px;
          vertical-align: text-bottom;
        }
        .system-name__name {
          font-size: var(--font-size-xl);
          font-weight: var(font-weight-bold);
          margin-left: 8px;
          display: inline-block;
          transition: all 0.5s;
        }
      }
      .menu-wrap {
        flex: 1;
      }
      .version {
        padding-left: var(--margin-xs);
        font-size: var(--font-size-sm);
        color: var(--font-color-secondary);
      }
    }

    .side-layout__workspace {
      background-color: var(--background-color-base);
      .header {
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
          padding-right: var(--padding-md);
          .header__message-navigation,
          .header__fullscreen,
          .header__light-dark,
          .header__avatar {
            margin-left: var(--margin-md);
          }
        }
      }
      .body {
        padding: var(--padding-md);
      }
    }
    &.side-layout__container--fold {
      .aside {
        width: 64px;
        .system-name {
          padding-left: 19px;
          .system-name__name {
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
    .side-layout__container {
      &.side-layout__container--fold {
        .aside {
          width: 0px;
        }
      }
    }
  }
}

//暗黑模式
.dark {
  .side-layout__container {
    .side-layout__workspace {
      .header {
        background-color: #141414;
      }
    }
  }
}
</style>
