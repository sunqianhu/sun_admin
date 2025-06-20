<template>
  <div ref="echartRef" class="echart"></div>
</template>

<script setup>
import { ref, onMounted, watch, onUnmounted } from "vue";
import * as echarts from "echarts";
import blueTheme from "@/extend/echarts_theme/blue.json";

let resizeObserver;
const props = defineProps({
  option: {
    type: Object,
    default: {},
  },
});

let chart = null;
const echartRef = ref(null);

/**
 * 注册主题
 */
const registerTheme = () => {
  echarts.registerTheme("blue_theme", blueTheme);
};

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
  chart.resize();
};

/**
 * 延时改变图表大小
 */
const delayResizeChart = () => {
  setTimeout(resizeChart, 100);
};

watch(
  () => props.option,
  (newValue) => {
    drawChart();
  },
  {
    deep: true,
  }
);

onMounted(() => {
  registerTheme();
  drawChart();

  const echartElement = echartRef.value;
  if (echartElement) {
    resizeObserver = new ResizeObserver(delayResizeChart);
    resizeObserver.observe(echartElement);
  }
});
onUnmounted(() => {
  if (chart) {
    chart.dispose();
    chart = null;
  }
  if (resizeObserver) {
    resizeObserver.disconnect();
  }
});
</script>

<style scoped lang="scss">
.echart {
}
</style>
