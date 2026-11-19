<template>
  <div class="top-navigation">
    <div class="system-name-row">
      <div class="system-name-row__left">
        <div class="system-name">
          <img src="@/assets/logo.png" class="logo" />
          <div class="system-info">
            <span class="name">{{ systemName }}</span>
            <span class="version">版本：{{ version }}</span>
          </div>
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
      <el-scrollbar view-style="width: max-content; min-width: 100%">
        <Menu></Menu>
      </el-scrollbar>
    </div>
    <quick-navigation
      v-if="themeStore.mainLayout_quickNavigation"
    ></quick-navigation>
    <el-main class="top-navigation__workspace">
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
import Menu from "./top_navigation/Menu.vue";
import QuickNavigation from "./QuickNavigation.vue";
import { useThemeStore } from "@/stores/theme";

const themeStore = useThemeStore();
const systemName = ref("");
const version = ref("");

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/layouts.main.TopNavigation/init");
  if (response.code != 0) {
    return;
  }
  systemName.value = response.data.system_name;
  version.value = response.data.version;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.top-navigation {
  position: absolute;
  left: 0px;
  right: 0px;
  top: 0px;
  bottom: 0px;
  .system-name-row {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    gap: var(--margin);
    padding: var(--padding-sm) var(--padding);
    background-color: var(--background-color-layout-main-header);
    .system-name-row__left {
      display: flex;
      align-items: center;
      flex-shrink: 0;
      .system-name {
        display: flex;
        .logo {
          height: 40px;
          padding-top: 4px;
        }
        .system-info {
          display: flex;
          flex-direction: column;
          line-height: 1.2;
          margin-left: 8px;
          .name {
            font-size: var(--font-size-xl);
            font-weight: var(--font-weight-bold);
          }
          .version {
            font-size: var(--font-size-sm);
            color: var(--font-color-secondary);
          }
        }
      }
    }
    .system-name-row__right {
      display: flex;
      align-items: center;
      justify-content: flex-end;
      flex-shrink: 0;
      margin-left: auto;
      .header__message-navigation,
      .header__fullscreen,
      .header__theme-setting,
      .header__light-dark,
      .header__avatar {
        margin-left: 24px;
      }
    }
  }
  .top-navigation__workspace {
    padding: var(--padding);
  }
}
</style>
