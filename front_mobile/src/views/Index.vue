<template>
  <div class="index">
    <div class="header">
      <div class="avatar">
        <van-image :src="user.avatar_url" fit="cover" round class="image" @click="openUserDetail" />
      </div>
      <div class="user">
        <div class="name" @click="openUserDetail">{{ user.name }}</div>
        <div class="description">{{ user.department_name }}</div>
      </div>
    </div>
    <div class="body">
      <panel-card title="功能导航" class="moudles">
        <van-row>
          <van-col span="6">
            <div class="moudle">
              <div class="icon">
                <van-icon name="user-o" />
              </div>
              <div class="text">用户管理</div>
            </div>
          </van-col>
          <van-col span="6">
            <div class="moudle">
              <div class="icon">
                <van-icon name="orders-o" />
              </div>
              <div class="text">订单管理</div>
            </div>
          </van-col>
          <van-col span="6">
            <div class="moudle">
              <div class="icon">
                <van-icon name="setting-o" />
              </div>
              <div class="text">系统设置</div>
            </div>
          </van-col>
        </van-row>
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
 * 打开用户详情页面
 */
const openUserDetail = () => {
  router.push("/my/user/detail");
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
    .moudles {
      .moudle {
        text-align: center;
        border-radius: var(--border-radius-md);
        padding: var(--padding-xs) 0px;
        &:active {
          background-color: var(--background-color-base);
        }
        .icon {
          font-size: 24px;
        }
        .text {
          margin-top: var(--margin-xs);
        }
      }
    }
  }
}
</style>
