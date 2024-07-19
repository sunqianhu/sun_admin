<template>
  <div class="test">
    <van-button type="primary">主要按钮</van-button>
    <van-button type="success">成功按钮</van-button>
    <van-button type="default">默认按钮</van-button>
    <van-button type="danger">危险按钮</van-button>
    <van-button type="warning">警告按钮</van-button>
  </div>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios.js";

const int = async () => {
  const response = await axios.get("desktop/statistic.Trend/init");
  console.log(`output->response`, response);
};
</script>

<style lang="scss" scoped>
.test {
}
</style>
