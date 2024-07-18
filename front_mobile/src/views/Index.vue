<template>
  <div class="index">
    用户首页

    <div v-permission="'module1'">moudle1</div>
    <div v-permission="'module22'">moudle2</div>
  </div>
</template>

<script setup>
import { ref } from "vue";
</script>

<style lang="scss" scoped>
.index {
}
</style>
