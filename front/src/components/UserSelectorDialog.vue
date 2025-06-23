<template>
  <el-dialog
    :model-value="true"
    title="选择用户"
    width="800"
    :draggable="true"
    :align-center="true"
    @close="close"
    class="user-selector-dialog"
  >
    <div class="searchbar">
      <el-form :model="query" :inline="true">
        <el-form-item label="部门">
          <tree-department-select
            v-model="query.department_ids"
            :multiple="true"
            filter
          ></tree-department-select>
        </el-form-item>
        <el-form-item label="姓名/手机号码">
          <el-input v-model="query.keyword" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search">
            搜索
          </el-button>
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
import { ref, watch, onMounted, nextTick } from "vue";
import { Search } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const props = defineProps({
  modelValue: {
    type: Number,
    default: 0,
  },
});
const emits = defineEmits(["close", "confirmed", "update:modelValue"]);
const query = ref({
  size: 30,
  page: 1,
});
const userId = ref(props.modelValue);
const selectedUser = ref({});
const users = ref([]);
const usersRef = ref(null);
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
  const response = await axios.get(
    "desktop/components.UserSelectorDialog/getPaginate",
    {
      params: query.value,
    }
  );
  paginateLoading.value = false;
  if (response.code != 1) {
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
 * 搜索
 */
const search = () => {
  getPaginate();
};

/**
 * 改变分页显示条数
 * @param {number} size
 */
const changePaginationSize = (size) => {
  query.value.size = size;
  query.value.number = 1;
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
  userId.value = selectedUser.value.id || 0;
  emits("update:modelValue", userId.value);
  emits("confirmed", selectedUser.value);
};

watch(
  () => props.modelValue,
  async (newValue) => {
    userId.value = newValue;
  },
  {
    deep: true,
  }
);

onMounted(() => {
  getPaginate();
});
</script>

<style lang="scss" scoped>
.user-selector-dialog {
  .searchbar {
    margin-top: var(--margin);
    .el-select {
      width: 198px;
    }
  }
  .list {
    margin-top: var(--margin);
    :deep(th.el-table__cell) {
      background-color: var(--background-color-dark);
    }
  }
  .pagination {
    margin-top: var(--margin);
  }
}
</style>
