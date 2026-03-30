<template>
  <div class="index" v-loading="initLoading">
    <div class="welcome">
      <img src="@/assets/index/welcome.svg" class="welcome__icon" />
      <div class="welcome__name">你好张三上午好，欢迎回来！</div>
    </div>

    <div class="count-statistic">
      <el-row justify="space-between" :gutter="16">
        <el-col :sm="12" :md="6">
          <div class="count-item">
            <div class="count-item__name">模块1</div>
            <div class="count-item__count">
              <el-icon class="count-item__icon"><Odometer /></el-icon>
              <span class="count-item__number">21</span>条
            </div>
          </div>
        </el-col>
        <el-col :sm="12" :md="6">
          <div class="count-item">
            <div class="count-item__name">模块2</div>
            <div class="count-item__count">
              <el-icon class="count-item__icon"><Odometer /></el-icon>
              <span class="count-item__number">17</span>条
            </div>
          </div>
        </el-col>
        <el-col :sm="12" :md="6">
          <div class="count-item">
            <div class="count-item__name">模块3</div>
            <div class="count-item__count">
              <el-icon class="count-item__icon"><Odometer /></el-icon>
              <span class="count-item__number">25</span>条
            </div>
          </div>
        </el-col>
        <el-col :sm="12" :md="6">
          <div class="count-item">
            <div class="count-item__name">模块4</div>
            <div class="count-item__count">
              <el-icon class="count-item__icon"><Odometer /></el-icon>
              <span class="count-item__number">14</span>条
            </div>
          </div>
        </el-col>
      </el-row>
    </div>

    <div class="modules">
      <el-row justify="space-between" :gutter="16">
        <el-col :md="12">
          <card-panel title="模块1" class="module">
            <echart :option="module1Option" class="module__chart"></echart>
          </card-panel>
        </el-col>
        <el-col :sm="12">
          <card-panel title="模块2" class="module">
            <echart :option="module2Option" class="module__chart"></echart>
          </card-panel>
        </el-col>
        <el-col :md="12">
          <card-panel title="模块3" class="module">
            <template #action>
              <a href="javascript:;">更多</a>
            </template>
            <el-table :data="tableData" style="width: 100%">
              <el-table-column prop="date" label="Date" width="120" />
              <el-table-column prop="name" label="Name" width="80" />
              <el-table-column prop="address" label="Address" />
            </el-table>
          </card-panel>
        </el-col>
        <el-col :sm="12">
          <card-panel title="模块4" class="module">
            <template #action>
              <a href="javascript:;">更多</a>
            </template>
            <el-table :data="tableData" style="width: 100%">
              <el-table-column prop="date" label="Date" width="120" />
              <el-table-column prop="name" label="Name" width="80" />
              <el-table-column prop="address" label="Address" />
            </el-table>
          </card-panel>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "@/helper/axios";
import { Odometer, ChatSquare } from "@element-plus/icons-vue";
import CardPanel from "@/components/CardPanel.vue";

const initLoading = ref(false);
const tableData = [
  {
    date: "2016-05-03",
    name: "Tom",
    address: "No. 189, Grove St, Los Angeles",
  },
  {
    date: "2016-05-02",
    name: "Tom",
    address: "No. 189, Grove St, Los Angeles",
  },
  {
    date: "2016-05-04",
    name: "Tom",
    address: "No. 189, Grove St, Los Angeles",
  },
  {
    date: "2016-05-01",
    name: "Tom",
    address: "No. 189, Grove St, Los Angeles",
  },
];
const module1Option = ref({});
const module2Option = ref({});

/**
 * 初始化
 */
const init = async () => {
  // initLoading.value = true;
  // const response = await axios.get("desktop/index/init");
  // initLoading.value = false;
  // if (response.code != 0) {
  //   ElMessage({
  //     message: response.message,
  //     type: "error"
  //   });
  //   return;
  // }

  setMoudle1Option();
  setMoudle2Option();
};

/**
 * 设置模块1选项
 */
const setMoudle1Option = () => {
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
        name: "舆情数量",
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
  let data = [
    {
      name: "18日",
      number: 12,
    },
    {
      name: "19日",
      number: 18,
    },
    {
      name: "20日",
      number: 15,
    },
    {
      name: "21日",
      number: 24,
    },
    {
      name: "22日",
      number: 19,
    },
  ];

  //数据
  data.forEach((item) => {
    option.xAxis.data.push(item.name);
    option.series[0].data.push(item.number);
  });

  module1Option.value = option;
};

/**
 * 设置模块2选项
 */
const setMoudle2Option = () => {
  let option = {
    tooltip: {
      trigger: "axis",
      axisPointer: {
        type: "shadow",
      },
    },
    grid: {
      left: "0",
      right: "10",
      top: "10",
      bottom: "0",
      containLabel: true,
    },
    xAxis: {
      type: "category",
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
        name: "数量",
        type: "bar",
        label: {
          show: true,
          color: "#ffffff",
        },
        data: [],
      },
    ],
  };
  let data = [
    {
      name: "bar1",
      number: Math.round(Math.random() * 100),
    },
    {
      name: "bar1",
      number: Math.round(Math.random() * 100),
    },
    {
      name: "bar1",
      number: Math.round(Math.random() * 100),
    },
    {
      name: "bar1",
      number: Math.round(Math.random() * 100),
    },
    {
      name: "bar1",
      number: Math.round(Math.random() * 100),
    },
  ];
  let length = data.length;
  let item;

  //数据
  for (let index = 0; index < length; index++) {
    item = data[index];
    if (index >= 10) {
      break;
    }
    option.xAxis.data.push(item.name);
    option.series[0].data.push(item.number);
  }
  module2Option.value = option;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.index {
  .welcome {
    background: var(--background-color-light);
    border-radius: var(--border-radius);
    padding: var(--padding);
    display: flex;
    align-items: center;
    box-shadow: var(--box-shadow);
    .welcome__icon {
      width: 50px;
      display: inline-block;
    }
    .welcome__name {
      font-size: var(--font-size-lg);
      color: var(--color-primary);
      margin-left: 16px;
    }
  }
  .count-statistic {
    margin-top: var(--margin);
    .count-item {
      padding: var(--padding);
      background-color: var(--background-color-light);
      border-radius: var(--border-radius);
      margin-bottom: var(--margin);
      box-shadow: var(--box-shadow);
      .count-item__name {
      }
      .count-item__count {
        margin-top: var(--margin);
        .count-item__icon {
          font-size: var(--font-size-xl);
          color: #8595f4;
        }
        .count-item__number {
          font-size: 32px;
          font-weight: var(--font-weight-bold);
          margin-left: 8px;
          margin-right: 4px;
        }
      }
    }
  }
  .modules {
    .module {
      margin-bottom: var(--margin);
      .module__chart {
        width: 100%;
        height: 250px;
      }
    }
  }
}
</style>
