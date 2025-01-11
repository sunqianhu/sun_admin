<template>
  <div class="side-layout">
    <el-container :class="{ fold: sideStore.fold }" class="container">
      <el-aside class="aside" id="aside">
        <div class="system-name">
          <img src="@/assets/logo.png" class="logo" />
          <span class="name">SunAdmin</span>
        </div>
        <el-scrollbar class="menu-wrap"><Menu></Menu></el-scrollbar>
        <div class="version">版本：{{ version }}</div>
      </el-aside>
      <el-container class="workspace">
        <el-header class="header">
          <div class="left">
            <hamburger class="hamburger"></hamburger>
          </div>
          <div class="right">
            <light-dark class="light-dark"></light-dark>
            <full-screen class="fullscreen"></full-screen>
            <avatar class="avatar"></avatar>
          </div>
        </el-header>
        <el-main class="body">
          <router-view v-slot="{ Component, route }">
            <keep-alive>
              <component :is="Component" v-if="route.meta?.keep_alive == true" />
            </keep-alive>
            <component :is="Component" v-if="route.meta?.keep_alive != true" />
          </router-view>
          <el-backtop :right="15" :bottom="15" target=".workspace .body"> UP </el-backtop>
        </el-main>
      </el-container>
    </el-container>
    <watermark />
    <message />
    <guide />
  </div>
</template>

<script setup>
import { useSideStore } from "@/stores/layouts/side";
import Menu from "./Menu.vue";
import LightDark from "./LightDark.vue";
import Hamburger from "./Hamburger.vue";
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
  .container {
    height: 100%;
    .aside {
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
      .menu-wrap {
        flex: 1;
      }
      .version {
        padding-left: var(--margin-xs);
        font-size: var(--font-size-sm);
        color: var(--font-color-secondary);
      }
    }

    .workspace {
      background-color: var(--background-color-base);
      .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 50px;
        background-color: #ffffff;
        box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
        padding: 0px;
        .left {
        }
        .right {
          display: flex;
          align-items: center;
          justify-content: flex-end;
          margin-right: var(--margin-md);
          .light-dark {
            margin-right: var(--margin-md);
          }
          .fullscreen {
            margin-right: var(--margin-md);
          }
        }
      }
      .body {
        padding: var(--padding-md);
      }
    }
    &.fold {
      .aside {
        width: 64px;
        .system-name {
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
    .container {
      &.fold {
        .aside {
          width: 0px;
        }
      }
    }
  }
}

//暗黑模式
.dark {
  .side-layout {
    .container {
      .aside {
        background-color: #141414;
      }
      .workspace {
        .header {
          background-color: #141414;
        }
      }
    }
  }
}
</style>
