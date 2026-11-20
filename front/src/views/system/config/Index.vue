<template>
  <div class="index" v-loading="initLoading">
    <page-header>
      系统设置
      <template #subtitle
        >系统相关设置</template
      >
    </page-header>
    <el-form
      :model="config"
      :rules="rules"
      label-width="120px"
      ref="configRef"
      class="form"
    >
      <el-form-item label="系统名称" prop="system_name">
        <el-input v-model="config.system_name" />
      </el-form-item>
      <el-form-item label="系统Logo" prop="system_logo">
        <div class="system-logo">
          <img :src="config.system_logo_url" alt="系统Logo" />
          <file-upload
            v-model="systemLogoFile"
            :data="{ module: 'system_logo' }"
            accept=".png,.jpg,.jpeg,.gif"
            :show-file-list="false"
            :disabled="submitLoading || uploadLoading"
            @success="changeSystemLogo"
          >
            <el-button
              :icon="Upload"
              :disabled="submitLoading || uploadLoading"
            >
              上传
            </el-button>
          </file-upload>
          <div class="text-tip">支持 PNG、JPG、GIF，建议使用正方形图片。</div>
        </div>
      </el-form-item>
      <el-form-item label="浏览器图标" prop="system_favicon">
        <div class="system-favicon">
          <img :src="config.system_favicon_url" alt="浏览器图标" />
          <file-upload
            v-model="systemFaviconFile"
            :data="{ module: 'system_favicon' }"
            accept=".ico"
            :show-file-list="false"
            :disabled="submitLoading || uploadLoading"
            @success="changeSystemFavicon"
          >
            <el-button
              :icon="Upload"
              :disabled="submitLoading || uploadLoading"
            >
              上传
            </el-button>
          </file-upload>
          <div class="text-tip">后缀名ico，最大2MB，保存并刷新页面后生效。</div>
        </div>
      </el-form-item>
      <el-form-item label="系统简介" prop="system_description">
        <el-input
          v-model="config.system_description"
          type="textarea"
          :rows="4"
          :maxlength="5000"
          show-word-limit
        />
      </el-form-item>
      <el-form-item label="禁止访问IP" prop="denied_ips_string">
        <el-input
          v-model="config.denied_ips_string"
          type="textarea"
          :rows="5"
        />
        <div class="text-tip">一行一个</div>
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          class="button"
          @click="submitForm"
          :loading="submitLoading"
          :disabled="uploadLoading"
        >
          保存
        </el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from "vue";
import { Upload } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const config = ref({});
const configRef = ref({});
const rules = {
  system_name: [{ required: true, message: "请输入系统名称", trigger: "blur" }],
  system_description: [
    {
      max: 5000,
      message: "系统简介不能超过5000个字符",
      trigger: "blur",
    },
  ],
};
const initLoading = ref(false);
const submitLoading = ref(false);
const systemLogoFile = ref([]);
const systemFaviconFile = ref([]);
const uploadLoading = computed(() =>
  [...systemLogoFile.value, ...systemFaviconFile.value].some((file) =>
    ["ready", "uploading"].includes(file.status),
  ),
);

/**
 * 切换系统logo
 */
const changeSystemLogo = (response) => {
  config.value.system_logo = response.data.path;
  config.value.system_logo_url = response.data.url;
};

/**
 * 切换系统浏览器图标
 */
const changeSystemFavicon = (response) => {
  config.value.system_favicon = response.data.path;
  config.value.system_favicon_url = response.data.url;
};

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.config.Index/init");
  } finally {
    initLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  config.value = response.data;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await configRef.value.validate();

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.config.Index/save",
      config.value,
    );
  } finally {
    submitLoading.value = false;
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
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-page);
  padding: var(--padding);
  border-radius: var(--border-radius);
  .form {
    max-width: 700px;
    margin-top: 16px;
    .system-logo,
    .system-favicon {
      display: flex;
      align-items: center;
      gap: var(--margin);
      img {
        width: 64px;
        height: 64px;
        object-fit: contain;
      }
    }
    .system-favicon img {
      width: 32px;
      height: 32px;
    }
    .el-select {
      width: 100%;
    }
    .submit-wrap {
      padding-left: 130px;
    }
  }
}
</style>
