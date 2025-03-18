<template>
  <div class="order-trend" v-loading="pageLoading">
    <div class="page-header">
      <span class="page-header__name">订单趋势统计</span>
      <span class="page-header__description">查看一段时间内订单趋势</span>
      <div class="page-header__actions">
        <el-button
          type="primary"
          :icon="Download"
          :loading="expLoading"
          @click="exp"
        >
          导出
        </el-button>
      </div>
    </div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="订单时间">
          <el-date-picker
            v-model="query.add_times"
            type="datetimerange"
            format="YYYY-MM-DD HH:mm:ss"
            value-format="X"
            range-separator="至"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
            editable
            unlink-panels
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search">
            搜索
          </el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="chart" id="chart"></div>
    <el-table :data="trend" row-key="name" class="list">
      <el-table-column prop="full_name" label="日期" />
      <el-table-column prop="count" label="订单数量" />
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Download, Search } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import * as echarts from "echarts";
import blueTheme from "@/extend/echarts_theme/blue.json";

const query = ref({
  add_times: [
    dayjs(
      dayjs().subtract(1, "month").format("YYYY-MM-DD") + " 00:00:00"
    ).unix(),
    dayjs(dayjs().add(1, "day").format("YYYY-MM-DD") + " 00:00:00").unix(),
  ],
});
const trend = ref([]);
let trendChart;
const pageLoading = ref(true);
const expLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  pageLoading.value = true;
  const response = await axios.get("desktop/statistic.OrderTrend/init", {
    params: query.value,
  });
  pageLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  trend.value = response.data;
  drawChart();
};

/**
 * 画图
 */
const drawChart = () => {
  let option = {
    tooltip: {},
    grid: {
      left: "0",
      right: "10",
      top: "10",
      bottom: "0",
      containLabel: true,
    },
    xAxis: {
      type: "category",
      boundaryGap: false, // 坐标轴两边留白策略
      data: [],
    },
    yAxis: {
      type: "value",
      axisLabel: {
        formatter: "{value}条",
      },
    },
    series: [
      {
        name: "订单数量",
        type: "line",
        areaStyle: {
          color: {
            type: "linear",
            x: 0,
            y: 0,
            x2: 0,
            y2: 1,
            colorStops: [
              {
                offset: 0,
                color: "#3fb1e3", // 0% 处的颜色
              },
              {
                offset: 1,
                color: "rgba(255,255,255,0)", // 100% 处的颜色
              },
            ],
          },
        }, // 区域填充样式
        data: [],
      },
    ],
  };
  let trendValue = trend.value;

  //数据
  trendValue.forEach((day) => {
    option.xAxis.data.push(day.name);
    option.series[0].data.push(day.count);
  });

  //画
  if (!trendChart) {
    let chartElement = document.getElementById("chart");
    trendChart = echarts.init(chartElement, "blue_theme");
  }
  trendChart.setOption(option);
};

/**
 * 导出
 */
const exp = async () => {
  expLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/statistic.OrderTrend/exp", {
      params: query.value,
    });
  } catch (error) {
    expLoading.value = false;
    return;
  }
  expLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
  }
  location.href =
    response.data + "?file_name=" + encodeURIComponent("订单趋势.xlsx");
};

/**
 * 搜索
 */
const search = () => {
  init();
};

onMounted(() => {
  echarts.registerTheme("blue_theme", blueTheme);
  init();
});
</script>

<style lang="scss" scoped>
.order-trend {
  background-color: var(--background-color-light);
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-header {
    display: flex;
    .page-header__name {
      font-size: var(--font-size-xl);
      font-weight: var(font-weight-bold);
    }
    .page-header__description {
      color: var(--font-color-secondary);
      margin-left: var(--margin);
      font-size: var(--font-size-sm);
      flex: 1;
    }
    .page-header__actions {
    }
  }
  .search {
    margin-top: var(--margin);
  }
  .chart {
    margin-top: var(--margin);
    height: 200px;
  }
  .list {
    margin-top: var(--margin);
    width: 100%;
    ::v-deep(th.el-table__cell) {
      background-color: var(--background-color-dark);
    }
  }
}
</style>
