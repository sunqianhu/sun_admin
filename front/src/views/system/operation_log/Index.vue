<template>
  <div class="index">
    <div class="page-name">操作日志</div>
    <div class="query-bar">
      <el-form :model="query" :inline="true" ref="queryRef">
        <el-form-item label="部门" prop="department_ids">
          <tree-department-select
            v-model="query.department_ids"
            multiple
          ></tree-department-select>
        </el-form-item>
        <el-form-item label="终端" prop="terminal">
          <dictionary-select
            v-model="query.terminal"
            type="terminal"
          ></dictionary-select>
        </el-form-item>
        <el-form-item label="业务码" prop="response_business_code">
          <dictionary-select
            v-model="query.response_business_code"
            type="response_business_code"
          ></dictionary-select>
        </el-form-item>
        <el-form-item label="用户姓名" prop="name">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item label="手机号码" prop="phone">
          <el-input v-model="query.phone" />
        </el-form-item>
        <el-form-item label="操作时间" prop="times">
          <el-date-picker
            v-model="query.times"
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
          <el-button :icon="RefreshLeft" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="tool-bar">
      <el-button @click="openTimeRangeDelete"> 删除 </el-button>
    </div>

    <div class="list">
      <el-table
        :data="operationLogs"
        v-loading="paginateLoading"
        row-key="id"
        table-layout="auto"
        class="table"
      >
        <el-table-column
          v-slot="{ row }"
          prop="department_name"
          label="所属部门"
          width="100"
          show-overflow-tooltip
        >
          {{ row.department_name || "未登录" }}
        </el-table-column>
        <el-table-column
          v-slot="{ row }"
          prop="user_name"
          label="用户姓名"
          width="100"
          show-overflow-tooltip
        >
          <a
            :href="'/system/user/detail-' + row.user_id"
            target="_blank"
            v-if="row.user_name"
          >
            {{ row.user_name }}
          </a>
          <span v-else>未登录</span>
        </el-table-column>
        <el-table-column label="操作时间" v-slot="{ row }" width="180">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
        <el-table-column
          v-slot="{ row }"
          label="业务码"
          width="110"
          show-overflow-tooltip
        >
          <el-tag
            :type="row.response_business_code == 0 ? 'success' : 'danger'"
          >
            {{ row.response_business_code_name }}
          </el-tag>
        </el-table-column>
        <el-table-column
          v-slot="{ row }"
          label="耗时"
          width="90"
          show-overflow-tooltip
        >
          {{ row.duration + "ms" }}
        </el-table-column>
        <el-table-column prop="request_method" label="请求方法" width="90" />
        <el-table-column prop="api" label="请求接口" show-overflow-tooltip />
        <el-table-column v-slot="{ row }" label="操作" fixed="right" width="90">
          <el-button size="small" @click="openDetail(row.id)">详情</el-button>
        </el-table-column>
      </el-table>
    </div>

    <div class="pagination">
      <el-pagination
        background
        layout="total,->,sizes,jumper,prev, pager, next"
        :page-sizes="[10, 30, 50, 100, 200, 300]"
        :page-size="query.size"
        :current-page="query.page"
        :total="total"
        @size-change="changePaginationSize"
        @current-change="changePaginationCurrent"
      />
    </div>

    <detail :id="rowId" @close="detailFlag = false" v-if="detailFlag"></detail>
    <time-range-delete
      @close="timeRangeDeleteFlag = false"
      @submited="
        query.page = 1;
        getPaginate();
        timeRangeDeleteFlag = false;
      "
      v-if="timeRangeDeleteFlag"
    ></time-range-delete>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import dayjs from "dayjs";
import { Search, RefreshLeft } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import Detail from "./Detail.vue";
import TimeRangeDelete from "./TimeRangeDelete.vue";

const queryRef = ref();
const query = ref({
  response_business_code: "",
  times: [
    dayjs(
      dayjs().subtract(6, "month").format("YYYY-MM-DD") + " 00:00:00",
    ).unix(),
    dayjs(dayjs().format("YYYY-MM-DD") + " 23:59:59").unix(),
  ],
  size: 30,
  page: 1,
});
const operationLogs = ref([]);
const paginateLoading = ref(true);
const total = ref(0);
const rowId = ref(0);
const detailFlag = ref(false);
const timeRangeDeleteFlag = ref(false);

/**
 * 得到分页
 */
const getPaginate = async () => {
  paginateLoading.value = true;
  let response;
  try {
    response = await axios.get(
      "desktop/system.operation_log.Index/getPaginate",
      {
        params: query.value,
      },
    );
  } finally {
    paginateLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  total.value = response.data.total;
  operationLogs.value = response.data.data;
};

/**
 * 提交查询
 */
const submitQuery = () => {
  query.value.page = 1;
  getPaginate();
};

/**
 * 重置查询
 */
const resetQuery = () => {
  queryRef.value.resetFields();
  submitQuery();
};

/**
 * 改变分页显示条数
 * @param {number} size
 */
const changePaginationSize = (size) => {
  query.value.size = size;
  query.value.page = 1;
  getPaginate();
};

/**
 * 处理分页当前页改变
 * @param {number} page
 */
const changePaginationCurrent = (page) => {
  query.value.page = page;
  getPaginate();
};

/**
 * 打开操作日志详情
 * @param {number} id
 */
const openDetail = (id) => {
  rowId.value = id;
  detailFlag.value = true;
};

/**
 * 打开删除操作日志
 */
const openTimeRangeDelete = () => {
  timeRangeDeleteFlag.value = true;
};

onMounted(() => {
  getPaginate();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-light);
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-name {
    font-size: var(--font-size-lg);
    font-weight: var(--font-weight-bold);
  }
  .query-bar {
    margin-top: var(--margin);
    .el-select {
      min-width: 198px;
    }
  }
  .tool-bar {
    margin-bottom: var(--margin);
  }
  .list {
    :deep(th.el-table__cell) {
      background-color: var(--background-color-lighter);
    }
    .table {
      width: 100%;
    }
  }
  .pagination {
    margin-top: var(--margin);
  }
}
</style>
