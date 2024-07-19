<template>
  <div class="test">
    <panel-card title="标题标题">内容</panel-card>

    <panel-inline title="标题标题" style="margin-top: 16px">内容</panel-inline>

    <label-value>
      <label-value-item label="添加事件">2024-07-19 21:23:33</label-value-item>
      <label-value-item label="添加事件">2024-07-19 21:23:33</label-value-item>
      <label-value-item label="添加事件">2024-07-19 21:23:33</label-value-item>
      <label-value-item label="添加事件">2024-07-19 21:23:33</label-value-item>
    </label-value>

    <table-label-value>
      <table-label-value-item label="添加事件">2024-07-19 21:23:33</table-label-value-item>
      <table-label-value-item label="添加事件">2024-07-19 21:23:33</table-label-value-item>
      <table-label-value-item label="添加事件" content-colspan="3"
        >2024-07-19 21:23:33</table-label-value-item
      >
    </table-label-value>
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
  background: #ffffff;
  padding: 30px;
}
</style>
