<template>
  <el-dialog
    :model-value="true"
    title="修改头像"
    width="800"
    :draggable="true"
    align-center
    @close="close"
  >
    <div class="edit-avatar">
      <el-row>
        <el-col :span="16" class="edit-avatar__left">
          <div class="cropper">
            <!--官网参考：https://github.com/xyxiao001/vue-cropper-->
            <vue-cropper
              :img="imgUrl"
              outputType="png"
              :outputSize="1"
              :info="false"
              :autoCrop="true"
              :autoCropWidth="350"
              :autoCropHeight="350"
              :fixed="true"
              :fixedNumber="[1, 1]"
              :limitMinSize="100"
              :maxImgSize="4000"
              :centerBox="false"
              fillColor="#ffffff"
              :full="true"
              @realTime="realTimePreview"
              ref="cropperRef"
            ></vue-cropper>
          </div>
          <div class="action">
            <el-upload
              :before-upload="uploadImageBefore"
              :show-file-list="false"
              class="upload-image"
            >
              <el-button type="primary" :icon="Upload">选择图片</el-button>
            </el-upload>
            <el-button :icon="ZoomIn" @click="scaleBig" />
            <el-button :icon="ZoomOut" @click="scaleSmall" />
            <el-button :icon="RefreshLeft" @click="rotateLeft" />
            <el-button :icon="RefreshRight" @click="rotateRight" />
          </div>
        </el-col>
        <el-col :span="8" class="edit-avatar__right">
          <div class="title">预览头像</div>
          <div class="preview">
            <div class="preview__show">
              <div :style="preview.div">
                <img :src="preview.url" :style="preview.img" />
              </div>
            </div>
          </div>
          <div class="save">
            <el-button type="primary" @click="save" :loading="saveLoading">
              保存
            </el-button>
          </div>
        </el-col>
      </el-row>
    </div>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import {
  Upload,
  ZoomOut,
  ZoomIn,
  RefreshLeft,
  RefreshRight,
} from "@element-plus/icons-vue";
import "vue-cropper/dist/index.css";
import { VueCropper } from "vue-cropper";

const emits = defineEmits(["close", "submited"]);
const user = ref({});
const cropperRef = ref();
const imgUrl = ref("");
const preview = ref({});
const saveLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/layouts.main.user.EditAvatar/init",
    {
      params: user.value,
    },
  );
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  imgUrl.value = response.data;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 上传图片前
 * @param {*} file
 */
const uploadImageBefore = (file) => {
  // 使用 FileReader 读取文件并设置给 selectedImage
  const reader = new FileReader();
  reader.onload = () => {
    imgUrl.value = reader.result;
  };
  reader.readAsDataURL(file);
  return false;
};

/**
 * 放大
 */
const scaleBig = () => {
  cropperRef.value.changeScale(1);
};

/**
 * 缩小
 */
const scaleSmall = () => {
  cropperRef.value.changeScale(-1);
};

/**
 * 向左旋转
 */
const rotateLeft = () => {
  cropperRef.value.rotateLeft();
};

/**
 * 向右旋转
 */
const rotateRight = () => {
  cropperRef.value.rotateRight();
};

/**
 * 实时预览
 * @param {*} data
 */
const realTimePreview = (data) => {
  preview.value = data;
  let scale = 100 / data.w;
  preview.value.div = {
    ...preview.value.div,
    transform: `scale(${scale})`,
    transformOrigin: "top left",
    position: "absolute",
    left: 0,
    top: 0,
  };
};

/**
 * 保存
 */
const save = () => {
  cropperRef.value.getCropData(async (data) => {
    user.value.avatar_base64_image_content = data;
    saveLoading.value = true;
    let response;
    try {
      response = await axios.post(
        "desktop/layouts.main.user.EditAvatar/save",
        user.value,
      );
    } finally {
      saveLoading.value = false;
    }
    if (response.code != 0) {
      ElMessage({
        message: response.message,
        type: "error",
      });
      return;
    }

    ElMessage({
      message: response.message,
      type: "success",
    });
    emits("submited", true);
  });
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.edit-avatar {
  .edit-avatar__left {
    .cropper {
      height: 350px;
      background-color: #888888;
      .image {
        max-width: 100%;
        max-height: 100%;
      }
    }
    .action {
      margin-top: var(--margin);
      .upload-image {
        display: inline-block;
        vertical-align: middle;
        margin-right: var(--margin);
      }
    }
  }
  .edit-avatar__right {
    padding-left: 16px;
    .preview {
      height: 329px;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
      .preview__show {
        width: 100px;
        height: 100px;
        overflow: hidden;
        border-radius: 50%;
        position: relative;
      }
    }
    .save {
      margin-top: var(--margin);
      text-align: center;
    }
  }
}
</style>
