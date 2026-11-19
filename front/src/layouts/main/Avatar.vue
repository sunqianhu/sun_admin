<template>
  <div class="avatar">
    <el-dropdown>
      <span class="avatar__link">
        <el-avatar
          shape="circle"
          :size="30"
          :src="user.avatar_url"
          class="avatar__avatar"
        ></el-avatar>
        <span class="avatar__name">{{ user.name }}</span>
        <el-icon class="avatar__arrow-down"><ArrowDown /></el-icon>
      </span>
      <template #dropdown>
        <el-dropdown-menu>
          <el-dropdown-item :icon="User" @click="openDetail">
            账号信息
          </el-dropdown-item>
          <el-dropdown-item :icon="Camera" @click="openAvatarEdit">
            修改头像
          </el-dropdown-item>
          <el-dropdown-item :icon="Edit" @click="openPasswordEdit">
            修改密码
          </el-dropdown-item>
          <el-dropdown-item :icon="Warning" @click="openAbout">
            关于系统
          </el-dropdown-item>
          <el-dropdown-item @click="logout">
            <el-icon>
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="1.8"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9" />
              </svg>
            </el-icon>
            退出登录
          </el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>

    <detail @close="detailFlag = false" v-if="detailFlag"></detail>
    <avatar-edit
      @close="avatarEditFlag = false"
      @submited="
        avatarEditFlag = false;
        init();
      "
      v-if="avatarEditFlag"
    ></avatar-edit>
    <password-edit
      @close="passwordEditFlag = false"
      @submited="passwordEditFlag = false"
      v-if="passwordEditFlag"
    ></password-edit>
    <about @close="aboutFlag = false" v-if="aboutFlag"></about>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import {
  Edit,
  User,
  Camera,
  ArrowDown,
  Warning,
} from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import { logout as session_logout } from "@/helper/session";
import Detail from "./user/Detail.vue";
import AvatarEdit from "./user/AvatarEdit.vue";
import PasswordEdit from "./user/PasswordEdit.vue";
import About from "./About.vue";

const detailFlag = ref(false);
const avatarEditFlag = ref(false);
const passwordEditFlag = ref(false);
const aboutFlag = ref(false);
const user = ref({});

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/layouts.main.Avatar/getUser");
  if (response.code != 0) {
    return;
  }

  user.value = response.data;
};

/**
 * 打开用户详情
 */
const openDetail = async () => {
  detailFlag.value = true;
};

/**
 * 打开头像修改
 */
const openAvatarEdit = async () => {
  avatarEditFlag.value = true;
};

/**
 * 打开密码修改
 */
const openPasswordEdit = async () => {
  passwordEditFlag.value = true;
};

/**
 * 打开关于系统
 */
const openAbout = () => {
  aboutFlag.value = true;
};

/**
 * 退出登录
 */
const logout = async () => {
  const response = await axios.get("desktop/layouts.main.Avatar/logout");
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  session_logout();
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.avatar {
  .avatar__link {
    cursor: pointer;
    display: flex;
    align-items: center;
    outline: none;
    .avatar__avatar {
    }
    .avatar__name {
      margin-left: 4px;
    }
    .avatar__arrow-down {
      margin-left: 4px;
    }
  }
}
</style>
