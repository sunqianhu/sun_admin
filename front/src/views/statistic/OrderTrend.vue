<template>
  <div class="order-trend" v-loading="initLoading">
    <div class="page-header">
      <span class="page-header__name">订单趋势统计</span>
      <span class="page-header__description">查看一段时间内订单趋势</span>
      <div class="page-header__action">
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
    <div class="query-bar">
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
          <el-button type="primary" :icon="Search" @click="submitQuery">
            查询
          </el-button>
        </el-form-item>
      </el-form>
    </div>
    <echart :option="option" class="chart"></echart>
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

const query = ref({
  add_times: [
    dayjs(
      dayjs().subtract(1, "month").format("YYYY-MM-DD") + " 00:00:00",
    ).unix(),
    dayjs(dayjs().format("YYYY-MM-DD") + " 23:59:59").unix(),
  ],
});
const initLoading = ref(true);
const expLoading = ref(false);
const trend = ref([]);
const option = ref({});

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/statistic.OrderTrend/init", {
      params: query.value,
    });
  } finally {
    initLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  trend.value = response.data;
  setOption();
};

/**
 * 设置选项
 */
const setOption = () => {
  let currentOption = {
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
  trendValue.forEach((day) => {
    currentOption.xAxis.data.push(day.name);
    currentOption.series[0].data.push(day.count);
  });
  option.value = currentOption;
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
    return;
  } finally {
    expLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
  }
  location.href =
    response.data + "?file_name=" + encodeURIComponent("订单趋势.xlsx");
};

/**
 * 提交查询
 */
const submitQuery = () => {
  init();
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.order-trend {
  background-color: var(--background-color-light);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  padding: var(--padding);
  .page-header {
    display: flex;
    .page-header__name {
      font-size: var(--font-size-lg);
    }
    .page-header__description {
      color: var(--font-color-secondary);
      margin-left: var(--margin);
      flex: 1;
    }
    .page-header__action {
    }
  }
  .query-bar {
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
