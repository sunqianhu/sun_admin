<template>
  <div class="login">
    <t-form
      ref="formRef"
      :data="user"
      :rules="rules"
      reset-type="initial"
      show-error-message
      label-align="left"
      @submit="submitForm"
    >
      <t-form-item label="用户名" name="name">
        <t-input v-model="user.name" borderless placeholder="请输入内容"></t-input>
      </t-form-item>
      <t-form-item label="密码" name="password">
        <t-input
          v-model="user.password"
          borderless
          :type="passwordInputType"
          :clearable="false"
          placeholder="请输入内容"
        >
          <template #suffixIcon>
            <BrowseOffIcon @click="changePasswordInputType()" />
          </template>
        </t-input>
      </t-form-item>
      <div class="button-wrap">
        <t-button theme="primary" type="submit" size="large" block>登录</t-button>
      </div>
    </t-form>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { BrowseOffIcon } from "tdesign-icons-vue-next";

const formRef = ref();
const user = ref({});
const rules = ref({
  name: [{ validator: (value) => value !== "", message: "账号不能为空" }],
  password: [{ validator: (value) => value !== "", message: "密码不能为空" }]
});
const passwordInputType = ref("password");

/**
 * 切换密码输入框类型
 */
const changePasswordInputType = () => {
  if (passwordInputType.value == "password") {
    passwordInputType.value = "text";
  } else {
    passwordInputType.value = "password";
  }
};

/**
 * 提交表单
 */
const submitForm = async () => {};
</script>

<style lang="scss" scoped>
:global(body) {
  background: var(--background-color-page-texture);
}
.login {
  .button-wrap {
    padding: var(--padding);
  }
}
</style>
