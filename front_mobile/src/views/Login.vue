<template>
  <div class="login">
    <van-form @submit="submitForm" class="form">
      <van-cell-group inset>
        <van-field
          v-model="username"
          name="账号"
          label="账号"
          placeholder="账号"
          :rules="[{ required: true, message: '账号不能为空' }]"
        />
        <van-field
          v-model="password"
          type="password"
          name="密码"
          label="密码"
          placeholder="密码"
          :rules="[{ required: true, message: '密码不能为空' }]"
        />
      </van-cell-group>
      <div class="button-wrap">
        <van-button type="primary" round block native-type="submit"> 登录 </van-button>
      </div>
    </van-form>
  </div>
</template>

<script setup>
import { ref } from "vue";

const formRef = ref();
const user = ref({});

/**
 * 提交表单
 */
const submitForm = async () => {};
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
