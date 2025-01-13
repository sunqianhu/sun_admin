<template>
  <div class="index">
    <div class="page-name">登录日志</div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="登录时间">
          <el-date-picker
            v-model="query.time"
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
        <el-form-item label="用户姓名">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item label="手机号码">
          <el-input v-model="query.phone" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search"
            >搜索</el-button
          >
        </el-form-item>
      </el-form>
    </div>

    <div class="list">
      <el-table
        :data="loginLogs"
        v-loading="listLoading"
        row-key="id"
        table-layout="auto"
        class="table"
      >
        <el-table-column prop="name" label="用户姓名" />
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
import { Search } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const query = ref({
  time: [
    dayjs(
      dayjs().subtract(3, "month").format("YYYY-MM-DD") + " 00:00:00"
    ).unix(),
    dayjs(dayjs().add(1, "day").format("YYYY-MM-DD") + " 00:00:00").unix(),
  ],
  size: 30,
  page: 1,
});
const loginLogs = ref([]);
const listLoading = ref(true);
const total = ref(0);

/**
 * 获取登录日志分页
 */
const getLoginLogPaginate = async () => {
  listLoading.value = true;
  const response = await axios.get(
    "desktop/system.login_log.Index/getLoginLogPaginate",
    {
      params: query.value,
    }
  );
  listLoading.value = false;
  if (response.code != 1) {
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
 * 搜索
 */
const search = () => {
  getLoginLogPaginate();
};

/**
 * 改变分页显示条数
 * @param {number} size
 */
const changePaginationSize = (size) => {
  query.value.size = size;
  query.value.number = 1;
  getLoginLogPaginate();
};

/**
 * 处理分页当前页改变
 * @param {number} page
 */
const changePaginationCurrent = (page) => {
  query.value.page = page;
  getLoginLogPaginate();
};

onMounted(() => {
  getLoginLogPaginate();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-light);
  padding: var(--padding-md);
  border-radius: var(--border-radius-md);
  box-shadow: var(--box-shadow-base);
  .page-name {
    font-size: var(--font-size-xl);
    font-weight: var(font-weight-bold);
  }
  .search {
    margin-top: var(--margin-md);
  }
  .list {
    :deep(th.el-table__cell) {
      background-color: var(--background-color-dark);
    }
    .table {
      width: 100%;
    }
  }
  .pagination {
    margin-top: var(--margin-md);
  }
}
</style>
