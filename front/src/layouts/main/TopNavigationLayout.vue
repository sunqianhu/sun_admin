<template>
  <div class="top-navigation-layout">
    <div class="system-name-row">
      <div class="system-name-row__left">
        <div class="system-name">
          <img src="@/assets/logo.png" class="logo" />
          <span class="name">{{ systemName }}</span>
        </div>
      </div>
      <div class="system-name-row__right">
        <message-navigation
          class="header__message-navigation"
        ></message-navigation>
        <full-screen class="header__fullscreen"></full-screen>
        <theme-setting class="header__theme-setting"></theme-setting>
        <light-dark class="header__light-dark"></light-dark>
        <avatar class="header__avatar"></avatar>
      </div>
    </div>
    <div class="navigation">
      <el-scrollbar>
        <Menu></Menu>
      </el-scrollbar>
    </div>
    <quick-navigation
      v-if="themeStore.mainLayout_quickNavigation"
    ></quick-navigation>
    <el-main class="top-navigation-layout__workspace">
      <router-view v-slot="{ Component, route }">
        <keep-alive v-if="route.meta?.keep_alive">
          <component :is="Component" />
        </keep-alive>
        <component :is="Component" v-else />
      </router-view>
      <el-backtop :right="15" :bottom="15"> UP </el-backtop>
    </el-main>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import axios from "@/helper/axios";
import LightDark from "./LightDark.vue";
import MessageNavigation from "./MessageNavigation.vue";
import FullScreen from "./FullScreen.vue";
import Avatar from "./Avatar.vue";
import ThemeSetting from "./ThemeSetting.vue";
import Menu from "./top_navigation_layout/Menu.vue";
import QuickNavigation from "./QuickNavigation.vue";
import { useThemeStore } from "@/stores/theme";

const themeStore = useThemeStore();
const systemName = ref("");

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/layouts.main.TopNavigationLayout/init"
  );
  if (response.code != 1) {
    return;
  }
  systemName.value = response.data.system_name;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.top-navigation-layout {
  background-color: var(--background-color);
  position: absolute;
  left: 0px;
  right: 0px;
  top: 0px;
  bottom: 0px;
  .system-name-row {
    display: flex;
    justify-content: space-between;
    padding: var(--padding) var(--padding);
    background-color: var(--background-color-light);
    .system-name-row__left {
      display: flex;
      align-items: center;
      .system-name {
        display: flex;
        align-items: center;
        .logo {
          height: 32px;
          margin-right: 8px;
        }
        .name {
          font-size: var(--font-size-xl);
          font-weight: var(--font-weight-bold);
        }
      }
    }
    .system-name-row__right {
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
  .top-navigation-layout__workspace {
    padding: var(--padding);
  }
}
</style>
