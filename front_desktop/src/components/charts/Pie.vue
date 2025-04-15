<template>
  <div
    ref="chartRef"
    class="pie"
    :style="{ width: width + 'px', height: height + 'px' }"
  ></div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import * as echarts from "echarts";
import blueTheme from "@/extend/echarts_theme/blue.json";

const props = defineProps({
  name: {
    type: String,
    default: "",
  },
  width: {
    type: Number,
    default: 500,
  },
  height: {
    type: Number,
    default: 500,
  },
  data: {
    type: Array,
    default: [],
  },
});

let chart = null;
const chartRef = ref(null);

/**
 * 画图
 */
const drawChart = () => {
  let option = {
    tooltip: {
      trigger: "item",
    },
    series: [
      {
        name: props.name,
        type: "pie",
        radius: ["30%", "80%"],
        padAngle: 5,
        data: props.data,
      },
    ],
  };
  if (!chart) {
    let chartElement = chartRef.value;
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
  }, 500);
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

window.addEventListener("resize", function () {
  resizeChart();
});
onMounted(() => {
  echarts.registerTheme("blue_theme", blueTheme);
  drawChart();
});
</script>

<style scoped lang="scss">
.pie {
}
</style>
