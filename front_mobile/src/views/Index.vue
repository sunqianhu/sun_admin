<template>
  <div class="index">
    <div class="header">
      <div class="avatar">
        <van-image :src="user.avatar_url" fit="cover" round class="image" @click="openMyDetail" />
      </div>
      <div class="user">
        <div class="name" @click="openMyDetail">{{ user.name }}</div>
        <div class="description">{{ user.department_name }}</div>
      </div>
    </div>
    <div class="body">
      <panel-card title="功能导航">
        <van-grid :border="false" :square="false" clickable>
          <van-grid-item icon="notes-o" text="功能1" to="/" />
          <van-grid-item icon="contact-o" text="用户管理" />
          <van-grid-item icon="setting-o" text="设置" />
        </van-grid>
      </panel-card>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import PanelCard from "@/components/PanelCard.vue";
import axios from "@/helper/axios";

const router = useRouter();
const user = ref({});

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("mobile/Index/init");
  if (response.code != 1) {
    showFailToast(response.message);
    return;
  }

  user.value = response.data.user;
};

/**
 * 打开我的详情页面
 */
const openMyDetail = () => {
  router.push("/my/detail");
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.index {
  padding: var(--padding-md);
  .header {
    display: flex;
    align-items: center;
    .avatar {
      .image {
        width: 80px;
        height: 80px;
        border: 2px solid #ffffff;
      }
    }
    .user {
      margin-left: var(--margin-md);
      .name {
        font-size: var(--font-size-xl);
        font-weight: var(--font-bold-bold);
      }
      .description {
        margin-top: var(--margin-sm);
      }
    }
  }
  .body {
    margin-top: var(--margin-md);
  }
}
</style>
