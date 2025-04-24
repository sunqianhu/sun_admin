<template>
  <div class="index">
    <div class="page-name">字典管理</div>
    <div class="searchbar">
      <el-form :model="query" :inline="true">
        <el-form-item label="字典类型">
          <el-input v-model="query.type" />
        </el-form-item>
        <el-form-item label="字典键">
          <el-input v-model="query.key" />
        </el-form-item>
        <el-form-item label="字典值">
          <el-input v-model="query.value" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search"
            >搜索</el-button
          >
        </el-form-item>
      </el-form>
    </div>

    <div class="toolbar">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>

    <div class="list">
      <el-table
        :data="dictionarys"
        v-loading="listLoading"
        row-key="id"
        class="table"
      >
        <el-table-column prop="type" label="字典类型" />
        <el-table-column prop="key" label="字典键" />
        <el-table-column prop="value" label="字典值" />
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
      @close="addFlag = false"
      @submited="
        getDictionaryPaginate();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <edit
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
  page: 1,
});
const dictionarys = ref([]);
const listLoading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);
const total = ref(0);

/**
 * 得到字典分页
 */
const getDictionaryPaginate = async () => {
  listLoading.value = true;
  const response = await axios.get(
    "desktop/system.dictionary.Index/getDictionaryPaginate",
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
    id: id,
  });
  if (response.code != 1) {
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
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-name {
    font-size: var(--font-size-xl);
    font-weight: var(font-weight-bold);
  }
  .searchbar {
    margin-top: var(--margin);
  }
  .toolbar {
  }
  .list {
    margin-top: var(--margin);
    :deep(th.el-table__cell) {
      background-color: var(--background-color-dark);
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
