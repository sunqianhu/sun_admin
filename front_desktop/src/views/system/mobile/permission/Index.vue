<template>
  <div class="index">
    <div class="page-name">权限管理</div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="权限名称">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item label="权限标识">
          <el-input v-model="query.key" />
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
        :data="treePermission"
        v-loading="listLoading"
        row-key="id"
        class="table"
      >
        <el-table-column v-slot="{ row }" prop="name" label="权限名称">
          {{ row.name }}
        </el-table-column>
        <el-table-column
          prop="key"
          label="权限标识"
          width="300"
          show-overflow-tooltip
        />
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
    <add
      @close="addFlag = false"
      @submited="
        getTreePermission();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <edit
      @close="editFlag = false"
      @submited="
        getTreePermission();
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
const treePermission = ref([]);
const listLoading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);

/**
 * 得到树权限
 */
const getTreePermission = async () => {
  listLoading.value = true;
  const response = await axios.get(
    "desktop/system.mobile.permission.Index/getTreePermission",
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
  treePermission.value = response.data;
};

/**
 * 搜索
 */
const search = () => {
  getTreePermission();
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
    "desktop/system.mobile.permission.Index/delete",
    {
      id: id,
    }
  );
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
  getTreePermission();
};

onMounted(() => {
  getTreePermission();
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
  .search {
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
}
</style>
