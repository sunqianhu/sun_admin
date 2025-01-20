<template>
  <div class="detail">
    <group-radius class="user">
      <edit-avatar :url="user.avatar_url" @successed="init"></edit-avatar>
      <van-cell title="姓名" :value="user.name" />
      <van-cell title="所属部门" :value="user.department_name" />
      <van-cell title="手机号码" :value="user.phone" />
    </group-radius>
    <div class="button-wrap">
      <van-button type="primary" block :loading="logoutLoading" @click="logout">
        退出登录
      </van-button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import axios from "@/helper/axios";
import EditAvatar from "./EditAvatar.vue";

const router = useRouter();
const user = ref({});
const logoutLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("mobile/my.user.Detail/init");
  if (response.code != 1) {
    showFailToast(response.message);
    return;
  }

  user.value = response.data.user;
};

/**
 * 退出登录
 */
const logout = async () => {
  logoutLoading.value = true;
  const response = await axios.get("mobile/my.user.Detail/logout");
  logoutLoading.value = false;
  if (response.code != 1) {
    showFailToast(response.message);
    return;
  }
  localStorage.removeItem("token");
  window.location.replace("/login");
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.detail {
  .user {
  }
  .button-wrap {
    padding: var(--padding-md);
  }
}
</style>
