<template>
  <div class="index">
    <div class="page-header">
      <span class="page-header__name">路由管理</span>
      <span class="page-header__description">前端路由管理</span>
    </div>
    <div class="query-bar">
      <el-form
        :model="query"
        :inline="true"
        ref="queryRef"
        @submit.prevent="submitQuery"
      >
        <el-form-item label="路由名称" prop="name">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" native-type="submit">
            查询
          </el-button>
          <el-button :icon="RefreshLeft" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="tool-bar">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>

    <div class="list">
      <el-table
        :data="routes"
        v-loading="listLoading"
        row-key="id"
        table-layout="auto"
        class="table"
      >
        <el-table-column v-slot="{ row }" prop="name" label="路由名称">
          {{ row.name }}
        </el-table-column>
        <el-table-column prop="key" label="路由标识" show-overflow-tooltip />
        <el-table-column prop="path" label="路由路径" show-overflow-tooltip />
        <el-table-column prop="sort" label="排序" width="60" />
        <el-table-column
          v-slot="{ row }"
          label="操作"
          fixed="right"
          width="140"
        >
          <el-button size="small" @click="openEdit(row.id)">修改</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="del(row.id)">
            <template #reference>
              <el-button size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </el-table-column>
      </el-table>
    </div>

    <add
      @close="addFlag = false"
      @submited="
        getRoutes();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <edit
      @close="editFlag = false"
      @submited="
        getRoutes();
        editFlag = false;
      "
      :id="rowId"
      v-if="editFlag"
    ></edit>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search, RefreshLeft, Plus } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import Add from "./Add.vue";
import Edit from "./Edit.vue";

const rowId = ref(0);
const queryRef = ref();
const query = ref({});
const routes = ref([]);
const listLoading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);

/**
 * 得到路由列表
 */
const getRoutes = async () => {
  listLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.desktop.route.Index/getRoutes", {
      params: query.value,
    });
  } finally {
    listLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  routes.value = response.data;
};

/**
 * 提交查询
 */
const submitQuery = () => {
  getRoutes();
};

/**
 * 重置查询
 */
const resetQuery = () => {
  queryRef.value.resetFields();
  submitQuery();
};

/**
 * 打开添加页面
 */
const openAdd = () => {
  addFlag.value = true;
};

/**
 * 打开修改
 */
const openEdit = (id) => {
  editFlag.value = true;
  rowId.value = id;
};

/**
 * 删除
 * @param {number} id
 */
const del = async (id) => {
  const response = await axios.post(
    "desktop/system.desktop.route.Index/delete",
    {
      id: id,
    },
  );
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  ElMessage({
    message: response.message,
    type: "success",
  });
  getRoutes();
};

onMounted(() => {
  getRoutes();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-page);
  padding: var(--padding);
  border-radius: var(--border-radius);
  .page-header {
    .page-header__name {
      font-size: var(--font-size-lg);
      font-weight: var(--font-weight-bold);
    }
    .page-header__description {
      color: var(--font-color-secondary);
      margin-left: var(--margin);
    }
  }
  .query-bar {
    margin-top: var(--margin);
  }
  .tool-bar {
  }
  .list {
    margin-top: var(--margin);
    .table {
      width: 100%;
      .remark {
        font-size: var(--font-size-sm);
        color: var(--font-color-secondary);
      }
    }
  }
}
</style>
