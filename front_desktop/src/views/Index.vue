<template>
  <div class="index">
    <div class="page-name">系统首页</div>
    <div class="welcome">欢迎登录系统</div>
  </div>
</template>

<script setup></script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-light);
  padding: 16px;
  border-radius: var(--border-radius-md);
  box-shadow: var(--box-shadow-base);
  .page-name {
    font-size: 20px;
    font-weight: bold;
  }
  .welcome {
    margin-top: var(--margin-md);
  }
}
</style>
