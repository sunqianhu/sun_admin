<template>
  <div class="xxx">
    <t-button size="large" theme="primary">填充按钮</t-button>
    <t-button size="large" theme="light">填充按钮</t-button>
    <t-button size="large">填充按钮</t-button>
  </div>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios.js";

const int = async () => {
  const response = await axios.get("desktop/statistic.Trend/init");
  console.log(`output->response`, response);
};
int();
</script>

<style lang="scss" scoped>
:global .xxx {
}
</style>
