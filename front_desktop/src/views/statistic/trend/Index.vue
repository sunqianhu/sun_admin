<template>
  <div class="trend" v-loading="pageLoading">
    <div class="page-header">
      <span class="name">趋势统计</span>
      <span class="description">订单趋势统计</span>
      <div class="operation">
        <el-button type="primary" @click="exportExcel" :loading="exportExcelLoading">
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
          <el-button type="primary" :icon="Search" @click="search">搜索</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="chart" id="chart"></div>
    <el-table :data="days" row-key="name" class="list">
      <el-table-column prop="full_name" label="日期" />
      <el-table-column prop="number" label="订单数量" />
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import * as echarts from "echarts";
import blueTheme from "@/extend/echarts_theme/blue.json";

const query = ref({
  add_times: [
    dayjs(dayjs().subtract(1, "month").format("YYYY-MM-DD") + " 00:00:00").unix(),
    dayjs(dayjs().add(1, "day").format("YYYY-MM-DD") + " 00:00:00").unix()
  ]
});
const days = ref([]);
const pageLoading = ref(true);
const exportExcelLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  pageLoading.value = true;
  const response = await axios.get("desktop/statistic.trend.Index/init", {
    params: query.value
  });
  pageLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  days.value = response.data;
  drawChart();
};

/**
 * 画图
 */
const drawChart = () => {
  let chartElement = document.getElementById("chart");
  let chart;
  let option = {
    tooltip: {},
    grid: {
      left: "0",
      right: "10",
      top: "10",
      bottom: "0",
      containLabel: true
    },
    xAxis: {
      type: "category",
      boundaryGap: false, // 坐标轴两边留白策略
      data: []
    },
    yAxis: {
      type: "value",
      axisLabel: {
        formatter: "{value}条"
      }
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
                color: "#3fb1e3" // 0% 处的颜色
              },
              {
                offset: 1,
                color: "rgba(255,255,255,0)" // 100% 处的颜色
              }
            ]
          }
        }, // 区域填充样式
        data: []
      }
    ]
  };
  let dayValues = days.value;

  //数据
  dayValues.forEach((day) => {
    option.xAxis.data.push(day.name);
    option.series[0].data.push(day.number);
  });

  //画
  chart = echarts.init(chartElement, "blue_theme");
  chart.setOption(option);
};

/**
 * 导出excel
 */
const exportExcel = async () => {
  exportExcelLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/statistic.trend.Index/exportExcel", {
      params: query.value,
      responseType: "blob"
    });
  } catch (error) {
    exportExcelLoading.value = false;
    return;
  }
  exportExcelLoading.value = false;

  const blob = new Blob([response], {
    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  });
  const url = window.URL.createObjectURL(blob);

  const link = document.createElement("a");
  link.href = url;
  link.download = "趋势统计.xlsx";
  document.body.appendChild(link);
  link.click();

  window.URL.revokeObjectURL(url);
  link.remove();
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
.trend {
  background-color: var(--background-color-light);
  padding: var(--padding-md);
  border-radius: var(--border-radius-md);
  box-shadow: var(--box-shadow-base);
  .page-header {
    display: flex;
    .name {
      font-size: 20px;
      font-weight: bold;
    }
    .description {
      color: var(--font-color-secondary);
      margin-left: var(--margin-md);
      font-size: var(--font-size-sm);
      flex: 1;
    }
    .operation {
    }
  }
  .search {
    margin-top: var(--margin-md);
  }
  .chart {
    margin-top: var(--margin-md);
    height: 200px;
  }
  .list {
    margin-top: var(--margin-md);
    width: 100%;
    ::v-deep(th.el-table__cell) {
      background-color: var(--background-color-dark);
    }
  }
}
</style>
