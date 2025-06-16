<template>
  <div ref="echartRef" class="echart"></div>
</template>

<script setup>
import { ref, onMounted, watch, onUnmounted } from "vue";
import * as echarts from "echarts";
import blueTheme from "@/extend/echarts_theme/blue.json";

const props = defineProps({
  option: {
    type: Object,
    default: {},
  },
});

let chart = null;
const echartRef = ref(null);

/**
 * 画图
 */
const drawChart = () => {
  let option = props.option;
  if (!chart) {
    let chartElement = echartRef.value;
    chart = echarts.init(chartElement, "blue_theme");
  }
  chart.setOption(option);
};

/**
 * 重绘
 */
const resizeChart = () => {
  setTimeout(() => {
    chart.resize();
  }, 10);
};

watch(
  () => props,
  (newValue) => {
    drawChart();
  },
  {
    deep: true,
  }
);

onMounted(() => {
  echarts.registerTheme("blue_theme", blueTheme);
  drawChart();
  window.addEventListener("resize", resizeChart);
});
onUnmounted(() => {
  if (chart) {
    chart.dispose();
    chart = null;
  }
  window.removeEventListener("resize", resizeChart);
});
</script>

<style scoped lang="scss">
.echart {
}
</style>
