<template>
  <div class="edit-avatar">
    <van-uploader :multiple="false" :max-count="1" accept="image/*" :after-read="readAvatar">
      <van-image :src="url" fit="cover" round class="avatar" />
    </van-uploader>

    <!--裁剪头像-->
    <van-dialog
      v-model:show="showCropperFlag"
      title="裁剪头像"
      width="100%"
      show-cancel-button
      @confirm="confirmCrop"
      @cancel="cancelCrop"
      class="cropper-dialog"
    >
      <img :src="selectedBase64Content" class="crop-image" />
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
    default: ""
  }
});
const emits = defineEmits(["successed"]);
const selectedBase64Content = ref(""); //选择的头像base64内容
const showCropperFlag = ref(false); //显示裁剪标识
let cropper = null; //裁剪器对象

/**
 * 读取头像
 */
const readAvatar = (file) => {
  if (!file) {
    return;
  }
  const reader = new FileReader();
  reader.onload = async (e) => {
    selectedBase64Content.value = e.target.result;
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
  const cropImage = document.querySelector(".crop-image");
  if (cropper) {
    cropper.destroy();
  }
  cropper = new Cropper(cropImage, {
    aspectRatio: 1,
    viewMode: 1,
    scalable: false, //裁剪区域是否可以缩放
    zoomable: false //裁剪区域是否可以缩放图像
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
  const base64Image = canvas.toDataURL("image/png"); // 或者 'image/png'
  showCropperFlag.value = false;
  save(base64Image);
}

/**
 * 取消裁剪
 */
function cancelCrop() {
  showCropperFlag.value = false;
}

/**
 * 保存头像
 */
const save = async (base64Content) => {
  showLoadingToast({
    duration: 0,
    forbidClick: true
  });
  const response = await axios.post("mobile/my.user.EditAvatar/save", {
    avatar_base64_content: base64Content
  });
  closeToast();

  if (response.code != 1) {
    showFailToast(response.message);
    return;
  }
  showSuccessToast(response.message);
  emits("successed", true);
};
</script>

<style lang="scss" scoped>
.edit-avatar {
  .avatar {
    width: 60px;
    height: 60px;
  }
  .cropper-dialog {
    .crop-image {
      width: 100%;
    }
  }
}
</style>
