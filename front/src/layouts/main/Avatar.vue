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
          <el-dropdown-item :icon="User" @click="openEditAvatar">
            修改头像
          </el-dropdown-item>
          <el-dropdown-item :icon="Edit" @click="openEditPassword">
            修改密码
          </el-dropdown-item>
          <el-dropdown-item :icon="SwitchButton" @click="logout">
            退出登录
          </el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>

    <detail @close="detailFlag = false" v-if="detailFlag"></detail>
    <edit-avatar
      @close="editAvatarFlag = false"
      @submited="
        editAvatarFlag = false;
        init();
      "
      v-if="editAvatarFlag"
    ></edit-avatar>
    <edit-password
      @close="editPasswordFlag = false"
      @submited="editPasswordFlag = false"
      v-if="editPasswordFlag"
    ></edit-password>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { Edit, SwitchButton, User, ArrowDown } from "@element-plus/icons-vue";
import { usePermissionStore } from "@/stores/permission";
import { useRouteStore } from "@/stores/route";
import routeCache from "@/helper/route_cache";
import permissionCache from "@/helper/permission_cache";
import watermarkCache from "@/helper/watermark_cache";
import axios from "@/helper/axios";
import Detail from "./user/Detail.vue";
import EditAvatar from "./user/EditAvatar.vue";
import EditPassword from "./user/EditPassword.vue";

const router = useRouter();
const detailFlag = ref(false);
const editAvatarFlag = ref(false);
const editPasswordFlag = ref(false);
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
 * 打开修改头像
 */
const openEditAvatar = async () => {
  editAvatarFlag.value = true;
};

/**
 * 打开修改密码
 */
const openEditPassword = async () => {
  editPasswordFlag.value = true;
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

  localStorage.removeItem("token");
  const permissionStore = usePermissionStore();
  permissionStore.clear();
  const routeStore = useRouteStore();
  routeStore.clear();
  permissionCache.clear();
  routeCache.clear();
  watermarkCache.clear();

  router.replace("/login");
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
