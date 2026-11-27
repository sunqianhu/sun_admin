<template>
  <div class="avatar-crop">
    <van-nav-bar
      title="裁剪头像"
      left-text="取消"
      right-text="完成"
      safe-area-inset-top
      class="avatar-crop__header"
      @click-left="back"
      @click-right="confirmCrop"
    />
    <div class="avatar-crop__body">
      <img
        v-if="image"
        ref="imageRef"
        :src="image"
        alt="待裁剪头像"
        class="avatar-crop__image"
        @error="showImageLoadError"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from "vue";
import { useRouter } from "vue-router";
import { useAvatarStore } from "@/stores/user/avatar";
import axios from "@/helper/axios";
import Cropper from "cropperjs";
import "cropperjs/dist/cropper.css";

const router = useRouter();
const avatarStore = useAvatarStore();
const image = avatarStore.image;
const imageRef = ref();
const ready = ref(false); // 裁剪器是否准备好
const saveLoading = ref(false);
let cropper = null;

/**
 * 退出裁剪
 */
const back = () => {
  router.back();
};

/**
 * 显示图片加载失败
 */
const showImageLoadError = () => {
  showFailToast("图片读取失败，请重新选择");
  router.back();
};

/**
 * 初始化裁剪
 */
const initCrop = () => {
  if (!image) {
    showFailToast("请先选择图片");
    router.back();
    return;
  }
  cropper = new Cropper(imageRef.value, {
    aspectRatio: 1,
    viewMode: 1,
    ready() {
      ready.value = true;
    },
  });
};

/**
 * 销毁裁剪器
 */
const destroyCrop = () => {
  if (cropper) {
    cropper.destroy();
    cropper = null;
  }
};

/**
 * 确定裁剪
 */
const confirmCrop = async () => {
  if (!ready.value) {
    showFailToast("裁剪器正在初始化，请稍后再试");
    return;
  }
  if (saveLoading.value) {
    showFailToast("裁剪中，请稍后再试");
    return;
  }
  const canvas = cropper.getCroppedCanvas();
  if (!canvas) {
    showFailToast("裁剪失败，请重新选择图片");
    return;
  }

  saveLoading.value = true;
  const toast = showLoadingToast({
    message: "保存中...",
    duration: 0,
    forbidClick: true,
  });
  let response;
  let error;
  try {
    response = await axios.post("mobile/my.user.AvatarCrop/save", {
      avatar_base64_image_content: canvas.toDataURL("image/png"),
    });
  } catch (exception) {
    error = exception;
  } finally {
    toast.close();
    saveLoading.value = false;
  }
  if (error) {
    showFailToast(error.message || "保存失败");
    return;
  }
  if (response.code != 0) {
    showFailToast(response.message);
    return;
  }
  showSuccessToast(response.message);
  router.back();
};

onMounted(() => {
  initCrop();
});

onBeforeUnmount(() => {
  destroyCrop();
  avatarStore.image = "";
});
</script>

<style lang="scss" scoped>
.avatar-crop {
  width: 100%;
  height: 100vh;
  height: 100dvh;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding-bottom: env(safe-area-inset-bottom);
  .avatar-crop__header {
    flex-shrink: 0;
  }
  .avatar-crop__body {
    flex: 1;
    min-height: 0;
    overflow: hidden;
    .avatar-crop__image {
      display: block;
      max-width: 100%;
    }
  }
}
</style>
