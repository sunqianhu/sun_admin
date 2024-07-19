<template>
  <div class="detail">
    <group-radius>
      <van-cell title="头像" value="内容" />
      <van-cell title="姓名" value="孙乾户" />
      <van-cell title="所属部门" value="部门1" />
      <van-cell title="手机号码" value="15108273576" />
    </group-radius>
    <div class="button-wrap">
      <van-button type="primary" plain block>退出登录</van-button>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
</script>

<style lang="scss" scoped>
.detail {
  padding: var(--padding-md);
  .button-wrap {
    margin-top: var(--margin-md);
  }
}
</style>
