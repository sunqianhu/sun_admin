<template>
  <div class="login">
    <div class="background">
      <video
        src="@/assets/login/background.mp4"
        autoplay
        loop
        muted
        playsinline
      ></video>
    </div>

    <div class="container">
      <div class="system-name">
        <img src="@/assets/logo.png" alt="logo" class="system-name__logo" />
        <span class="system-name__name">{{ systemName }}</span>
      </div>
      <div class="welcome">又见面啦！请输入账号和密码登录系统</div>

      <el-form
        :model="session"
        :rules="rules"
        scroll-to-error
        ref="sessionRef"
        label-position="top"
        class="form"
        @keyup.enter="verify"
      >
        <el-form-item label="账号" prop="account">
          <el-input
            v-model="session.account"
            :prefix-icon="User"
            size="large"
            placeholder="请输入账号"
          />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input
            v-model="session.password"
            type="password"
            show-password
            size="large"
            :prefix-icon="Lock"
            placeholder="请输入密码"
          />
        </el-form-item>
        <el-form-item class="submit">
          <el-button
            type="primary"
            size="large"
            @click="verify"
            class="button"
            :loading="submitLoading"
          >
            登录
          </el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="footer">
      <div class="browser">
        浏览器支持：Edge ≥ 85 Firefox≥79 Chrome≥85 Safari≥14.1
      </div>
      <div class="copyright">
        Copyright &copy; {{ new Date().getFullYear() }} jfwind
      </div>
    </div>

    <vcode
      :show="vCodeFlag"
      @success="
        vCodeFlag = false;
        submitForm();
      "
      @close="vCodeFlag = false"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { User, Lock } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import Vcode from "vue3-puzzle-vcode";

const systemName = ref("");
const session = ref({});
const sessionRef = ref(null);
const rules = {
  account: [{ required: true, message: "请输入账号", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }],
};
const submitLoading = ref(false);
const vCodeFlag = ref(false);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("desktop/Login/init");
  if (response.code != 0) {
    return;
  }
  systemName.value = response.data.system_name;
  document.title = systemName.value;
};

/**
 * 验证
 */
const verify = async () => {
  await sessionRef.value.validate();
  vCodeFlag.value = true;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  submitLoading.value = true;
  let response;
  try {
    response = await axios.post("desktop/login/login", session.value);
  } catch (error) {
    submitLoading.value = false;
    return;
  }
  submitLoading.value = false;
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  localStorage.setItem("token", response.data);
  location.replace("./");
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.login {
  position: absolute;
  overflow: hidden;
  left: 0px;
  top: 0px;
  right: 0px;
  bottom: 0px;
  .background {
    position: absolute;
    left: 0px;
    right: 0px;
    top: 0px;
    bottom: 0px;
    z-index: 1;
    background-color: #141414;
    background-image: url("@/assets/login/background.png");
    background-size: 100% 100%;
    video {
      width: 100%;
      height: 100%;
      object-fit: fill;
    }
  }
  .container {
    padding: 32px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    z-index: 3;
    background: var(--background-color-opacity-light);
    border-radius: var(--border-radius-lg);
    box-shadow: 0px 0px 32px rgba(0, 0, 0, 0.12);
    .system-name {
      display: flex;
      align-items: center;
      justify-content: center;
      .system-name__logo {
        height: 30px;
      }
      .system-name__name {
        margin-left: var(--margin);
        font-size: 24px;
        font-weight: var(--font-weight-bold);
      }
    }
    .welcome {
      margin-top: var(--margin-sm);
      text-align: center;
      font-size: var(--font-size-sm);
      color: var(--font-color-placeholder);
    }
    .form {
      margin-top: 16px;
      width: 300px;
      :deep(.el-input .el-input__inner:-webkit-autofill) {
        box-shadow: 0 0 0px 1000px white inset;
      }
      .submit {
        margin-top: 32px;
        .button {
          width: 100%;
        }
      }
    }
  }
  .footer {
    position: absolute;
    left: var(--margin);
    right: var(--margin);
    bottom: var(--margin);
    z-index: 2;
    text-align: center;
    font-size: var(--font-size-sm);
    color: var(--font-color-secondary);
  }
}
</style>
