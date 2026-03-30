<template>
  <div class="index">
    <div class="header">
      <div class="header__avatar">
        <van-image
          :src="user.avatar_url"
          fit="cover"
          round
          class="header__image"
          @click="openUserDetail"
        />
      </div>
      <div class="header__user">
        <div class="header__name" @click="openUserDetail">{{ user.name }}</div>
        <div class="header__description">{{ user.department_name }}</div>
      </div>
    </div>
    <div class="body">
      <van-cell-group inset>
        <van-cell title="功能1" icon="location-o" is-link />
        <van-cell title="功能2" icon="location-o" is-link />
        <van-cell title="功能3" icon="location-o" is-link />
        <van-cell title="功能4" icon="location-o" is-link />
        <van-cell title="功能5" icon="location-o" is-link />
      </van-cell-group>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import axios from "@/helper/axios";

const router = useRouter();
const user = ref({});

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("mobile/Index/init");
  if (response.code != 0) {
    //showFailToast(response.message);
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
  .header {
    padding: var(--padding);
    display: flex;
    align-items: center;
    .header__avatar {
      .header__image {
        width: 80px;
        height: 80px;
        border: 2px solid #ffffff;
      }
    }
    .header__user {
      margin-left: var(--margin);
      .header__name {
        font-size: var(--font-size-xl);
        font-weight: var(--font-bold-bold);
      }
      .header__description {
        margin-top: var(--margin-sm);
      }
    }
  }
  .body {
    margin-top: var(--margin);
    .moudles {
      .moudle {
        text-align: center;
        border-radius: var(--border-radius);
        padding: var(--padding-sm) 0px;
        &:active {
          background-color: var(--background-color);
        }
        .icon {
          font-size: 24px;
        }
        .text {
          margin-top: var(--margin-sm);
        }
      }
      .margin-bottom-md {
        margin-bottom: var(--margin);
      }
    }
  }
}
</style>
