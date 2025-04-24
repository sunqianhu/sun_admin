<template>
  <div class="login">
    <van-form
      scroll-to-error
      required
      ref="sessionRef"
      @submit="submitForm"
      class="form"
    >
      <van-field
        v-model="session.account"
        name="account"
        label="账号"
        placeholder="账号"
        :rules="[{ required: true, message: '账号不能为空' }]"
        clearable
      />
      <van-field
        v-model="session.password"
        type="password"
        name="password"
        label="密码"
        placeholder="密码"
        :rules="[{ required: true, message: '密码不能为空' }]"
        clearable
      />

      <div class="button-wrap">
        <van-button
          type="primary"
          :loading="submitLoading"
          round
          block
          native-type="submit"
        >
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
const submitLoading = ref(false);

/**
 * 提交表单
 */
const submitForm = async () => {
  submitLoading.value = true;
  try {
    const response = await axios.post("mobile/login/login", session.value);
  } catch (e) {
    console.log(e);
  } finally {
    submitLoading.value = false;
  }
  if (response.code != 1) {
    showFailToast(response.message);
    return;
  }

  localStorage.setItem("token", response.data);
  router.push("/");
};
</script>

<style lang="scss" scoped>
.login {
  .form {
    .button-wrap {
      padding: var(--padding);
    }
  }
}
</style>
