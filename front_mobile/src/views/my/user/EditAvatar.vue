<template>
  <div class="edit-avatar">
    <van-uploader
      :multiple="false"
      :max-count="1"
      accept="image/*"
      :after-read="readAvatar"
      class="uploader"
    >
      <van-cell title="头像" center is-link>
        <template #value>
          <van-image :src="url" fit="cover" round class="uploader__avatar" />
        </template>
      </van-cell>
    </van-uploader>

    <!--裁剪头像-->
    <van-dialog
      v-model:show="showCropperFlag"
      title="裁剪头像"
      width="100%"
      show-cancel-button
      @confirm="confirmCrop"
      @cancel="cancelCrop"
      class="cropper"
    >
      <img :src="selectedBase64ImageContent" class="cropper__image" />
    </van-dialog>
  </div>
</template>

<script setup>
import { ref, nextTick } from "vue";
import axios from "@/helper/axios";
import Cropper from "cropperjs";
import "cropperjs/dist/cropper.css";

const props = defineProps({
  url: {
    type: String,
    default: "",
  },
});
const emits = defineEmits(["successed"]);
const selectedBase64ImageContent = ref(""); //选择的头像base64内容
const showCropperFlag = ref(false); //显示裁剪标识
let cropper = null; //裁剪器对象

/**
 * 读取头像
 */
const readAvatar = (file) => {
  if (!file) {
    showFailToast("未选择图片");
    return;
  }
  const reader = new FileReader();
  reader.onload = async (e) => {
    selectedBase64ImageContent.value = e.target.result;
    showCropperFlag.value = true;
    await nextTick();
    initCropper();
  };
  reader.readAsDataURL(file.file);
};

/**
 * 初始化裁剪器
 */
const initCropper = () => {
  const cropperImage = document.querySelector(".cropper__image");
  if (cropper) {
    cropper.destroy();
  }
  cropper = new Cropper(cropperImage, {
    aspectRatio: 1,
    viewMode: 1,
    scalable: true, //裁剪区域是否可以缩放
    zoomable: true, //裁剪区域是否可以缩放图像
  });
};

/**
 * 确定裁剪
 */
function confirmCrop() {
  if (!cropper) {
    showFailToast("裁剪器初始化失败");
    return;
  }
  const canvas = cropper.getCroppedCanvas();
  const base64ImageContent = canvas.toDataURL("image/png");
  showCropperFlag.value = false;
  save(base64ImageContent);
}

/**
 * 取消裁剪
 */
function cancelCrop() {
  showCropperFlag.value = false;
}

/**
 * 保存头像
 * @param base64ImageContent
 */
const save = async (base64ImageContent) => {
  showLoadingToast({
    duration: 0,
    forbidClick: true,
  });
  const response = await axios.post("mobile/my.user.EditAvatar/save", {
    avatar_base64_image_content: base64ImageContent,
  });
  closeToast();

  if (response.code != 0) {
    showFailToast(response.message);
    return;
  }
  showSuccessToast(response.message);
  emits("successed", true);
};
</script>

<style lang="scss" scoped>
.edit-avatar {
  .uploader {
    width: 100%;
    :deep(.van-uploader__wrapper) {
      display: block;
    }
    .uploader__avatar {
      width: 50px;
      height: 50px;
    }
  }
  .cropper {
    .cropper__image {
      width: 100%;
    }
  }
}
</style>
