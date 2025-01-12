<template>
  <div class="watermark" v-if="show">
    <div class="watermark__item" v-for="index in 100">
      <div class="watermark__name">{{ data.user_name + data.user_id }}</div>
      <div class="watermark__time">{{ data.date_time }}</div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

const data = ref({});
const show = ref(false);

/**
 * 初始化
 */
const init = async () => {
  show.value = false;
  const response = await axios.get("desktop/Frame/getWatermark");
  if (response.code != 1) {
    return;
  }
  show.value = true;
  data.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.watermark {
  pointer-events: none;
  position: fixed;
  left: 0px;
  top: 0px;
  right: 0px;
  bottom: 0px;
  z-index: 3002;
  overflow: hidden;
  .watermark__item {
    float: left;
    margin: 50px;
    text-align: center;
    opacity: 0.2;
    transform: rotate(-30deg);
    .watermark__name {
      font-size: var(--font-size-lg);
    }
  }
}
</style>
