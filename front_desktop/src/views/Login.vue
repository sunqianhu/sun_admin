<template>
  <div class="login">
    <div class="background">
      <video src="@/assets/login/background.mp4" autoplay loop muted></video>
    </div>
    <div class="form-wrap">
      <div class="header">
        <div class="title">
          <img src="@/assets/logo.png" class="logo" alt="logo" />
          <span class="name">SunAdmin</span>
        </div>
      </div>
      <el-form
        :model="session"
        :rules="rules"
        scroll-to-error
        ref="sessionRef"
        class="form"
        @keyup.enter="verify"
      >
        <el-form-item prop="account">
          <el-input
            :prefix-icon="User"
            placeholder="请输入账号"
            size="large"
            v-model="session.account"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            type="password"
            placeholder="请输入密码"
            show-password
            size="large"
            :prefix-icon="Lock"
            v-model="session.password"
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
      <div class="copyright">Copyright &copy; 2024 asun</div>
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
import { ref } from "vue";
import { User, Lock } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import Vcode from "vue3-puzzle-vcode";

const session = ref({});
const sessionRef = ref(null);
const rules = {
  account: [{ required: true, message: "账号不能为空", trigger: "blur" }],
  password: [{ required: true, message: "密码不能为空", trigger: "blur" }],
};
const submitLoading = ref(false);
const vCodeFlag = ref(false);

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
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  localStorage.setItem("token", response.data);
  location.replace("./");
};
</script>

<style lang="scss" scoped>
.login {
  height: 100dvh;
  position: relative;
  overflow: hidden;
  .background {
    position: absolute;
    left: 0px;
    right: 0px;
    top: 0px;
    bottom: 0px;
    z-index: 1;
    background: #001437;
    video {
      width: 100%;
      height: 100%;
      object-fit: fill;
    }
  }
  .form-wrap {
    padding: 32px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    z-index: 3;
    background: var(--background-color-opacity-light);
    border-radius: var(--border-radius-lg);
    box-shadow: 0px 0px 32px rgba(0, 0, 0, 0.12);
    .header {
      text-align: center;
      .title {
        line-height: 44px;
        .logo {
          height: 30px;
          vertical-align: -4px;
        }
        .name {
          margin-left: 12px;
          font-size: 24px;
          font-weight: var(font-weight-bold);
        }
      }
    }
    .form {
      margin-top: 50px;
      width: 300px;
      .submit {
        margin-top: 50px;
        .button {
          width: 100%;
        }
      }
    }
  }
  .footer {
    position: absolute;
    left: var(--margin-md);
    right: var(--margin-md);
    bottom: var(--margin-md);
    z-index: 2;
    text-align: center;
    font-size: var(--font-size-sm);
    color: var(--font-color-secondary);
  }
}
</style>
