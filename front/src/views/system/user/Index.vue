<template>
  <div class="index">
    <div class="page-header">
      <div class="page-header__name">用户管理</div>
      <div class="page-header__description">管理用户账号、所属部门和角色</div>
    </div>

    <div class="query-bar">
      <el-form :model="query" :inline="true" ref="queryRef">
        <el-form-item label="部门" prop="department_ids">
          <tree-department-select
            v-model="query.department_ids"
            multiple
          ></tree-department-select>
        </el-form-item>
        <el-form-item label="角色" prop="role_id">
          <role-select v-model="query.role_id"></role-select>
        </el-form-item>
        <el-form-item label="账号" prop="account">
          <el-input v-model="query.account" />
        </el-form-item>
        <el-form-item label="手机" prop="phone">
          <el-input v-model="query.phone" />
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="submitQuery">
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
        :data="users"
        v-loading="paginateLoading"
        stripe
        table-layout="auto"
        class="table"
      >
        <el-table-column v-slot="{ row }" prop="account" label="账号">
          <a
            :href="'/system/user/detail-' + row.id"
            target="_blank"
            class="account"
          >
            <el-avatar :size="30" :src="row.avatar_url" />
            <span class="account__account">{{ row.account }} </span>
          </a>
        </el-table-column>
        <el-table-column prop="name" label="姓名" />
        <el-table-column v-slot="{ row }" prop="department_name" label="部门">
          {{ row.department?.name }}
        </el-table-column>
        <el-table-column prop="phone" label="手机号码" />
        <el-table-column v-slot="{ row }" prop="add_time" label="添加时间">
          {{ dayjs.unix(row.add_time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
        <el-table-column v-slot="{ row }" prop="status" label="状态">
          <el-switch
            :model-value="row.status == 1 ? true : false"
            @change="editStatus(row)"
          />
        </el-table-column>
        <el-table-column
          v-slot="{ row }"
          label="操作"
          fixed="right"
          width="150"
        >
          <el-button size="small" @click="openEdit(row.id)">修改</el-button>
          <el-dropdown style="margin-left: 16px">
            <el-button size="small">
              更多
              <el-icon><arrow-down /></el-icon>
            </el-button>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="openPasswordEdit(row.id)"
                  >修改密码</el-dropdown-item
                >
                <el-dropdown-item
                  v-if="hasPermission(['system_user_desktop_offline'])"
                  @click="desktopOffline(row.id)"
                >
                  踢桌面端下线
                </el-dropdown-item>
                <el-dropdown-item
                  v-if="hasPermission(['system_user_mobile_offline'])"
                  @click="mobileOffline(row.id)"
                >
                  踢移动端下线
                </el-dropdown-item>
                <el-dropdown-item
                  v-if="hasPermission(['system_user_api_offline'])"
                  @click="apiOffline(row.id)"
                >
                  踢API端下线
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
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

    <add
      @close="addFlag = false"
      @submited="
        getPaginate();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <edit
      @close="editFlag = false"
      @submited="
        getPaginate();
        editFlag = false;
      "
      :id="rowId"
      v-if="editFlag"
    ></edit>
    <PasswordEdit
      :open="passwordEditFlag"
      :user_id="rowId"
      @close="passwordEditFlag = false"
      @submited="passwordEditFlag = false"
      v-if="passwordEditFlag"
    ></PasswordEdit>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";
import { hasPermission } from "@/helper/permission";
import dayjs from "dayjs";
import { Search, RefreshLeft, ArrowDown, Plus } from "@element-plus/icons-vue";
import Add from "./Add.vue";
import Edit from "./Edit.vue";
import PasswordEdit from "./PasswordEdit.vue";

const queryRef = ref();
const query = ref({
  size: 30,
  page: 1,
});
const paginateLoading = ref(true);
const users = ref([]);
const total = ref(0);
const rowId = ref(0);
const addFlag = ref(false);
const editFlag = ref(false);
const passwordEditFlag = ref(false);

/**
 * 得到分页
 */
const getPaginate = async () => {
  paginateLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.user.Index/getPaginate", {
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
  users.value = response.data.data;
  total.value = response.data.total;
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
 * 改变分页当前页
 * @param {*} page
 */
const changePaginationCurrent = (page) => {
  query.value.page = page;
  getPaginate();
};

/**
 * 打开添加
 */
const openAdd = () => {
  addFlag.value = true;
};

/**
 * 打开修改
 */
const openEdit = (id) => {
  rowId.value = id;
  editFlag.value = true;
};

/**
 * 修改状态
 * @param {number} id 记录id
 */
const editStatus = async (row) => {
  row.status = row.status == 1 ? 0 : 1;
  const response = await axios.post("desktop/system.user.Index/editStatus", {
    id: row.id,
    status: row.status,
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
};

/**
 * 打开密码修改
 * @param {number} id 记录id
 */
const openPasswordEdit = async (id) => {
  rowId.value = id;
  passwordEditFlag.value = true;
};

/**
 * 踢桌面端下线
 * @param {number} id 记录id
 */
const desktopOffline = async (id) => {
  await ElMessageBox.confirm("确定将用户的桌面端踢下线吗？", "提示", {
    draggable: true,
  });

  const response = await axios.post(
    "desktop/system.user.Index/desktopOffline",
    { id: id },
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
};

/**
 * 踢移动端下线
 * @param {number} id 记录id
 */
const mobileOffline = async (id) => {
  await ElMessageBox.confirm("确定将用户的移动端踢下线吗？", "提示", {
    draggable: true,
  });

  const response = await axios.post("desktop/system.user.Index/mobileOffline", {
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
};

/**
 * 踢API端下线
 * @param {number} id 记录id
 */
const apiOffline = async (id) => {
  await ElMessageBox.confirm("确定将用户的API端踢下线吗？", "提示", {
    draggable: true,
  });

  const response = await axios.post("desktop/system.user.Index/apiOffline", {
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
  box-shadow: var(--box-shadow);
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
  .tool-bar {
  }
  .list {
    margin-top: var(--margin);
    :deep(th.el-table__cell) {
      background-color: var(--background-color-lighter);
    }
    .table {
      width: 100%;
      .account {
        display: flex;
        align-items: center;
        .account__account {
          margin-left: var(--margin-sm);
        }
      }
    }
  }
  .pagination {
    margin-top: var(--margin);
  }
}
</style>
