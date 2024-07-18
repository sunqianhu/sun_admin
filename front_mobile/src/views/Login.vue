<template>
  <div class="login">
    <van-form scroll-to-error required ref="sessionRef" @submit="submitForm" class="form">
      <van-cell-group inset>
        <van-field
          v-model="session.account"
          name="账号"
          label="账号"
          placeholder="账号"
          :rules="[{ required: true, message: '账号不能为空' }]"
          clearable
        />
        <van-field
          v-model="session.password"
          type="password"
          name="密码"
          label="密码"
          placeholder="密码"
          :rules="[{ required: true, message: '密码不能为空' }]"
          clearable
        />
      </van-cell-group>
      <div class="button-wrap">
        <van-button type="primary" :loading="loading" round block native-type="submit">
          登录
        </van-button>
      </div>
    </van-form>
  </div>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios";
import { useRouter } from "vue-router";

const router = useRouter();
const session = ref({});
const sessionRef = ref();
const loading = ref(false);

/**
 * 提交表单
 */
const submitForm = async () => {
  let response;
  loading.value = true;
  try {
    response = await axios.post("mobile/login/login", session.value);
  } catch (error) {
    console.log(`output->error`, error);
    loading.value = false;
    return;
  }
  loading.value = false;
  if (response.code != 1) {
    showFailToast(response.message);
    return;
  }

  localStorage.setItem("token", response.data.token);
  router.push("/index");
};
</script>

<style lang="scss" scoped>
.login {
  padding-top: var(--padding-md);
  .form {
    .button-wrap {
      padding: var(--padding-md);
    }
  }
}
</style>
