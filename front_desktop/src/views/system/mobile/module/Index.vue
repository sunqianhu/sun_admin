<template>
  <div class="index">
    <div class="page-name">移动端模块管理</div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="模块名称">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search">查询</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="tool">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>
    <div class="list">
      <el-table :data="modules" v-loading="loading" row-key="id" class="table">
        <el-table-column v-slot="{ row }" prop="name" label="模块名称">
          {{ row.name }}
          <span v-if="row.remark" class="remark">{{ row.remark }}</span>
        </el-table-column>
        <el-table-column prop="key" label="模块key" width="300" show-overflow-tooltip />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column v-slot="{ row }" label="操作" fixed="right" width="140">
          <el-button size="small" @click="openEdit(row.id)">修改</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="del(row.id)">
            <template #reference>
              <el-button size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </el-table-column>
      </el-table>
    </div>
    <div class="explain">模块不生成前端路由，前端路由使用静态路由。</div>
    <add
      :open="addFlag"
      @close="addFlag = false"
      @submited="
        getModules();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <edit
      :open="editFlag"
      @close="editFlag = false"
      @submited="
        getModules();
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
const query = ref({});
const modules = ref([]);
const loading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);

/**
 * 得到模块
 */
const getModules = async () => {
  loading.value = true;
  const response = await axios.get("desktop/system.mobile.Module/getIndexModules", {
    params: query.value
  });
  loading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  modules.value = response.data;
};

/**
 * 搜索
 */
const search = () => {
  getModules();
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
  const response = await axios.post("desktop/system.mobile.Module/delete", {
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
  getModules();
};

onMounted(() => {
  getModules();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-light);
  padding: var(--padding-md);
  border-radius: var(--border-radius-md);
  box-shadow: var(--box-shadow-base);
  .page-name {
    font-size: 20px;
    font-weight: bold;
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

      .remark {
        font-size: var(--font-size-sm);
        color: var(--font-color-secondary);
      }
    }
  }
  .explain {
    margin-top: var(--margin-md);
    font-size: var(--font-size-sm);
    color: var(--font-color-secondary);
  }
}
</style>
