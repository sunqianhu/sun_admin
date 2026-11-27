<template>
  <div class="avatar-edit">
    <van-uploader
      :multiple="false"
      :max-count="1"
      accept="image/*"
      :after-read="readAvatar"
      class="uploader"
    >
      <van-cell title="头像" center is-link>
        <template #value>
          <van-image :src="url" fit="cover" round class="image" />
        </template>
      </van-cell>
    </van-uploader>
  </div>
</template>

<script setup>
import { useRouter } from "vue-router";
import { useAvatarStore } from "@/stores/user/avatar";

defineProps({
  url: {
    type: String,
    default: "",
  },
});
const router = useRouter();
const avatarStore = useAvatarStore();

/**
 * 读取头像
 */
const readAvatar = (file) => {
  if (!file || !file.content) {
    showFailToast("未选择图片");
    return;
  }
  avatarStore.image = file.content;
  router.push("/my/user/avatar-crop");
};
</script>

<style lang="scss" scoped>
.avatar-edit {
  .uploader {
    width: 100%;
    :deep(.van-uploader__wrapper) {
      display: block;
    }
    .image {
      width: 50px;
      height: 50px;
    }
  }
}
</style>
