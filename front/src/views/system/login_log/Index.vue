<template>
  <div class="index">
    <div class="page-header">
      <div class="page-header__name">登录日志</div>
      <div class="page-header__description">查看用户登录时间、终端和 IP</div>
    </div>
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
        <el-form-item label="登录时间" prop="times">
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
        <el-form-item label="用户姓名" prop="name">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item label="手机号码" prop="phone">
          <el-input v-model="query.phone" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="submitQuery">
            查询
          </el-button>
          <el-button :icon="RefreshLeft" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="list">
      <el-table
        :data="loginLogs"
        v-loading="paginateLoading"
        row-key="id"
        table-layout="auto"
        class="table"
      >
        <el-table-column prop="terminal_name" label="终端" />
        <el-table-column prop="department_name" label="所属部门" />
        <el-table-column v-slot="{ row }" prop="user_name" label="用户姓名">
          <a :href="'/system/user/detail-' + row.user_id" target="_blank">
            {{ row.user_name }}
          </a>
        </el-table-column>
        <el-table-column prop="ip" label="登录ip" />
        <el-table-column label="登录时间" v-slot="{ row }">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
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
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import dayjs from "dayjs";
import { Search, RefreshLeft } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const queryRef = ref();
const query = ref({
  times: [
    dayjs(
      dayjs().subtract(6, "month").format("YYYY-MM-DD") + " 00:00:00",
    ).unix(),
    dayjs(dayjs().format("YYYY-MM-DD") + " 23:59:59").unix(),
  ],
  size: 30,
  page: 1,
});
const loginLogs = ref([]);
const paginateLoading = ref(true);
const total = ref(0);

/**
 * 得到分页
 */
const getPaginate = async () => {
  paginateLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.login_log.Index/getPaginate", {
      params: query.value,
    });
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
  loginLogs.value = response.data.data;
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

onMounted(() => {
  getPaginate();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-light);
  padding: var(--padding);
  border-radius: var(--border-radius);
  .page-header {
    display: flex;
    .page-header__name {
      font-size: var(--font-size-lg);
      font-weight: var(--font-weight-bold);
    }
    .page-header__description {
      color: var(--font-color-secondary);
      margin-left: var(--margin);
      flex: 1;
    }
  }
  .query-bar {
    margin-top: var(--margin);
    .el-select {
      min-width: 198px;
    }
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
