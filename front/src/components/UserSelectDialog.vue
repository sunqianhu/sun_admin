<template>
  <el-dialog
    :model-value="true"
    title="选择用户"
    width="800"
    :draggable="true"
    :align-center="true"
    append-to-body
    @close="close"
    class="user-select-dialog"
  >
    <div class="query-bar">
      <el-form :model="query" :inline="true" ref="queryRef">
        <el-form-item label="部门" prop="department_ids">
          <tree-department-select
            v-model="query.department_ids"
            :multiple="true"
            filter
          ></tree-department-select>
        </el-form-item>
        <el-form-item label="姓名/手机号码" prop="keyword">
          <el-input v-model="query.keyword" />
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
        :data="users"
        row-key="id"
        highlight-current-row
        v-loading="paginateLoading"
        ref="usersRef"
        class="table"
        height="350"
        @current-change="selectUser"
      >
        <el-table-column prop="name" label="姓名" />
        <el-table-column prop="department.name" label="所属部门" />
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
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" @click="confirmSelect"> 确定 </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search, RefreshLeft } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const emits = defineEmits(["close", "confirmed"]);
const queryRef = ref();
const query = ref({
  size: 30,
  page: 1,
});
const userId = defineModel({
  type: Number,
  default: 0,
});
const selectedUser = ref(null);
const users = ref([]);
const paginateLoading = ref(false);
const total = ref(0);

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 得到分页
 */
const getPaginate = async () => {
  paginateLoading.value = true;
  let response;
  try {
    response = await axios.get(
      "desktop/components.UserSelectDialog/getPaginate",
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
  users.value = response.data.data;
};

/**
 * 选择用户
 * @param currentRow
 * @param oldCurrentRow
 */
const selectUser = (currentRow, oldCurrentRow) => {
  selectedUser.value = currentRow;
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
 * 确定选择
 */
const confirmSelect = () => {
  if (!selectedUser.value) {
    ElMessage({
      message: "请选择用户",
      type: "warning",
    });
    return;
  }
  userId.value = selectedUser.value.id;
  emits("confirmed", selectedUser.value);
};

onMounted(() => {
  getPaginate();
});
</script>

<style lang="scss" scoped>
.user-select-dialog {
  .query-bar {
    margin-top: var(--margin);
    .el-select {
      width: 198px;
    }
  }
  .list {
    margin-top: var(--margin);
    :deep(th.el-table__cell) {
      background-color: var(--background-color-lighter);
    }
  }
  .pagination {
    margin-top: var(--margin);
  }
}
</style>
