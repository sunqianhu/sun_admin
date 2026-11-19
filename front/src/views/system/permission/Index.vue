<template>
  <div class="index">
    <div class="page-header">
      <div class="page-header__name">功能权限</div>
      <div class="page-header__description">维护功能权限标识和关联接口</div>
    </div>
    <div class="query-bar">
      <el-form
        :model="query"
        :inline="true"
        ref="queryRef"
        @submit.prevent="submitQuery"
      >
        <el-form-item label="权限名称" prop="name">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item label="权限标识" prop="key">
          <el-input v-model="query.key" />
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
      <el-button
        v-permission="['system_permission_add']"
        type="primary"
        :icon="Plus"
        @click="openAdd"
        >添加</el-button
      >
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
          <el-button
            v-permission="['system_permission_edit']"
            size="small"
            @click="openEdit(row.id)"
            >修改</el-button
          >
          <el-popconfirm title="确定删除吗？" @confirm="del(row.id)">
            <template #reference>
              <el-button
                v-permission="['system_permission_delete']"
                size="small"
                >删除</el-button
              >
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
import { Search, RefreshLeft, Plus } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import Add from "./Add.vue";
import Edit from "./Edit.vue";

const rowId = ref(0);
const queryRef = ref();
const query = ref({});
const treePermission = ref([]);
const listLoading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);

/**
 * 得到权限
 */
const getTreePermission = async () => {
  listLoading.value = true;
  let response;
  try {
    response = await axios.get(
      "desktop/system.permission.Index/getTreePermission",
      {
        params: query.value,
      },
    );
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
  treePermission.value = response.data;
};

/**
 * 提交查询
 */
const submitQuery = () => {
  getTreePermission();
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
  const response = await axios.post("desktop/system.permission.Index/delete", {
    id: id,
  });
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
  getTreePermission();
};

onMounted(() => {
  getTreePermission();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-page);
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
  }
  .tool-bar {
  }
  .list {
    margin-top: var(--margin);
    .table {
      width: 100%;
    }
  }
}
</style>
