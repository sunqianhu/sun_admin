<template>
  <div class="department" v-loading="loading">
    <div class="page-header">
      <span class="name">部门统计</span>
      <span class="description">按部门统计订单量</span>
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

    <el-table :data="departments" row-key="name" class="list">
      <el-table-column prop="name" label="部门" />
      <el-table-column prop="number" label="订单量" />
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
const departments = ref([]);
const pageLoading = ref(true);
const exportExcelLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  pageLoading.value = true;
  const response = await axios.get("desktop/statistic.Department/init", {
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

  departments.value = response.data;
  drawChart();
};

/**
 * 画图
 */
const drawChart = () => {
  let chartElement = document.getElementById("chart");
  let chart;

  let option = {
    grid: {
      left: "0",
      right: "10",
      top: "10",
      bottom: "0",
      containLabel: true
    },
    xAxis: {
      type: "category",
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
        type: "bar",
        label: {
          show: true,
          color: "#ffffff"
        },
        data: []
      }
    ]
  };
  let departmentValues = departments.value;
  let length = departmentValues.length;
  let department;

  //数据
  for (let index = 0; index < length; index++) {
    department = departmentValues[index];
    if (index >= 10) {
      break;
    }
    option.xAxis.data.push(department.name);
    option.series[0].data.push(department.number);
  }

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
    response = await axios.get("desktop/statistic.Department/exportExcel", {
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
  link.download = "部门统计.xlsx";
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
.department {
  background-color: var(--background-color-panel);
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-header {
    display: flex;
    .name {
      font-size: 20px;
      font-weight: bold;
    }
    .description {
      color: var(--font-color-secondary);
      margin-left: var(--margin);
      font-size: var(--font-size-small);
      flex: 1;
    }
    .operation {
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
      background-color: var(--background-color-table-header);
    }
  }
}
</style>
