<template>
  <div class="login">
    <div class="main">
      <div class="main__left">
        <div class="system-logo" v-if="systemLogoUrl !== ''">
          <img :src="systemLogoUrl" alt="系统Logo" />
        </div>
        <h1 class="system-name">{{ systemName }}</h1>
        <div class="version" v-if="version !== ''">版本 {{ version }}</div>
      </div>

      <div class="main__right">
        <div class="panel">
          <div class="page-header">
            <div class="page-header__name">账号登录</div>
            <div class="page-header__description">请输入您的账号和密码</div>
          </div>
          <el-form
            :model="session"
            :rules="rules"
            scroll-to-error
            ref="sessionRef"
            label-position="top"
            class="form"
            @submit.prevent="verify"
          >
            <el-form-item label="账号" prop="account">
              <el-input
                v-model="session.account"
                :prefix-icon="User"
                placeholder="请输入账号"
                autocomplete="username"
                autocapitalize="none"
                :spellcheck="false"
              />
            </el-form-item>
            <el-form-item label="密码" prop="password">
              <el-input
                v-model="session.password"
                type="password"
                show-password
                :prefix-icon="Lock"
                placeholder="请输入密码"
                autocomplete="current-password"
              />
            </el-form-item>
            <el-form-item class="submit-row">
              <el-button
                type="primary"
                native-type="submit"
                :loading="submitLoading"
                class="button"
              >
                {{ submitLoading ? "正在登录" : "登录" }}
              </el-button>
            </el-form-item>
          </el-form>
          <div class="help">忘记密码？请联系管理员</div>
        </div>
        <div class="footer">
          支持浏览器：Edge ≥ 85 Firefox≥79 Chrome≥85 Safari≥14.1<br />
          2024至{{ new Date().getFullYear() }} &copy; {{ systemName }}
        </div>
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
import { login } from "@/helper/session";
import Vcode from "vue3-puzzle-vcode";

const systemName = ref("");
const systemLogoUrl = ref("");
const version = ref("");
const session = ref({});
const sessionRef = ref();
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
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  systemName.value = response.data.system_name;
  systemLogoUrl.value = response.data.system_logo_url;
  version.value = response.data.version;
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

  login(response.data);
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.login {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  height: 100dvh;
  overflow: hidden;
  background: linear-gradient(
    120deg,
    var(--el-color-primary-light-7),
    var(--background-color-light),
    var(--el-color-primary-light-9)
  );
  background-size: 200% 200%;
  animation: login-background 8s ease-in-out infinite alternate;
  .main {
    display: flex;
    width: 840px;
    overflow: hidden;
    border-radius: var(--border-radius-lg);
    background-color: var(--background-color-page);
    z-index: 2;
    .main__left {
      position: relative;
      display: flex;
      flex-direction: column;
      justify-content: center;
      box-sizing: border-box;
      flex: 0 0 36%;
      padding: var(--padding-lg);
      overflow: hidden;
      color: #ffffff;
      background: linear-gradient(155deg, #1e3054, #233c67);
      &::after {
        position: absolute;
        right: -100px;
        bottom: -160px;
        width: 300px;
        height: 300px;
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 50%;
        content: "";
        pointer-events: none;
      }
      .system-logo {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        width: 48px;
        height: 48px;
        border-radius: var(--border-radius);
        background-color: #ffffff;
        img {
          display: block;
          width: 32px;
          height: 32px;
          object-fit: contain;
        }
      }
      .system-name {
        font-size: var(--font-size-xl);
        font-weight: var(--font-weight-bold);
        line-height: 1.5;
        overflow-wrap: anywhere;
        margin: 0px;
        margin-top: var(--margin-sm);
      }
      .version {
        font-size: var(--font-size-sm);
        color: #b9c7df;
      }
    }
    .main__right {
      display: flex;
      flex: 1;
      flex-direction: column;
      padding: 24px 40px;
      .panel {
        width: 320px;
        margin: auto;
        .page-header {
          .page-header__name {
            font-size: var(--font-size-xl);
            font-weight: var(--font-weight-bold);
            line-height: 32px;
          }
          .page-header__description {
            margin-top: var(--margin-sm);
            color: var(--font-color-secondary);
            line-height: 20px;
          }
        }
        .form {
          margin-top: 24px;
          :deep(.el-form-item) {
            margin-bottom: var(--margin);
          }
          :deep(.el-form-item__label::before) {
            display: none;
          }
          :deep(.el-input__wrapper) {
            box-sizing: border-box;
            height: 40px;
            padding: 0px 12px;
            border-radius: var(--border-radius);
          }
          .submit-row {
            margin-top: 24px;
            .button {
              width: 100%;
              height: 40px;
              border-radius: var(--border-radius);
            }
          }
        }
        .help {
          margin-top: var(--margin);
          color: var(--font-color-secondary);
          font-size: var(--font-size-xs);
          text-align: center;
        }
      }
      .footer {
        margin-top: var(--margin);
        color: var(--font-color-tertiary);
        font-size: var(--font-size-xs);
        text-align: center;
      }
    }
  }
}

@keyframes login-background {
  from {
    background-position: 0% 50%;
  }
  to {
    background-position: 100% 50%;
  }
}

@media (prefers-reduced-motion: reduce) {
  .login {
    animation: none;
  }
}

@media (max-width: 640px) {
  .login {
    padding: var(--padding);
    .main {
      flex-direction: column;
      width: 100%;
      max-width: 400px;
      .main__left {
        flex: 0 0 auto;
        padding: 20px 24px;
        display: grid;
        grid-template-columns: 48px minmax(0, 1fr);
        column-gap: var(--margin);
        align-items: center;
        .system-logo {
          grid-row: span 2;
        }
        .system-name {
          font-size: var(--font-size-lg);
          margin-top: 0px;
        }
      }
      .main__right {
        flex: 0 1 auto;
        padding: 24px;
        .panel {
          width: 100%;
          max-width: 320px;
        }
      }
    }
  }
}
</style>
