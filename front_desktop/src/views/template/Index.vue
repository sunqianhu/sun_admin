<template>
  <div class="index">
    <div class="page-header">
      <div class="page-header__name">字典管理</div>
      <div class="page-header__description">字典管理描述</div>
      <div class="page-header__actions"></div>
    </div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="字典名称">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search">
            搜索
          </el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="toolbar">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>

    <div class="list">
      <el-table
        :data="dictionarys"
        v-loading="loading"
        row-key="id"
        table-layout="auto"
        class="table"
      >
        <el-table-column v-slot="{ row }" prop="account" label="账号">
          <a :href="'/system/user/detail-' + row.id" target="_blank">
            {{ row.account }}
          </a>
        </el-table-column>
        <el-table-column prop="sort" label="排序" width="100" />
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

    <add
      :open="addFlag"
      @close="addFlag = false"
      @submited="
        getDictionaryPaginate();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <edit
      :open="editFlag"
      @close="editFlag = false"
      @submited="
        getDictionaryPaginate();
        editFlag = false;
      "
      :id="rowId"
      v-if="editFlag"
    ></edit>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search, Plus } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import Add from "./Add.vue";
import Edit from "./Edit.vue";

const rowId = ref(0);
const query = ref({
  size: 30,
  page: 1
});
const dictionarys = ref([]);
const loading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);
const total = ref(0);

/**
 * 得到字典分页
 */
const getDictionaryPaginate = async () => {
  loading.value = true;
  const response = await axios.get(
    "desktop/system.dictionary.Index/getDictionaryPaginate",
    {
      params: query.value
    }
  );
  loading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  total.value = response.data.total;
  dictionarys.value = response.data.data;
};

/**
 * 搜索
 */
const search = () => {
  getDictionaryPaginate();
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
  const response = await axios.post("desktop/system.dictionary.Index/delete", {
    id: id
  });
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  ElMessage({
    message: response.message,
    type: "success"
  });
  getDictionaryPaginate();
};

/**
 * 改变分页显示条数
 * @param {number} size
 */
const changePaginationSize = (size) => {
  query.value.size = size;
  query.value.number = 1;
  getDictionaryPaginate();
};

/**
 * 处理分页当前页改变
 * @param {number} page
 */
const changePaginationCurrent = (page) => {
  query.value.page = page;
  getDictionaryPaginate();
};

onMounted(() => {
  getDictionaryPaginate();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-light);
  padding: var(--padding-md);
  border-radius: var(--border-radius-md);
  box-shadow: var(--box-shadow-base);
  .page-header {
    display: flex;
    .page-header__name {
      font-size: var(--font-size-xl);
      font-weight: var(font-weight-bold);
    }
    .page-header__description {
      color: var(--font-color-secondary);
      margin-left: var(--margin-md);
      font-size: var(--font-size-sm);
      flex: 1;
    }
    .actions {
    }
  }
  .search {
    margin-top: var(--margin-md);
  }
  .toolbar {
  }
  .list {
    margin-top: var(--margin-md);
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
