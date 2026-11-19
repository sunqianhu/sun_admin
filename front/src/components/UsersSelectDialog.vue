<template>
  <el-dialog
    :model-value="true"
    title="选择用户"
    width="1000"
    :draggable="true"
    :align-center="true"
    append-to-body
    @close="close"
    class="users-select-dialog"
  >
    <el-row :gutter="16">
      <el-col :span="16">
        <flag-title-panel title="待选用户">
          <div class="user-panel">
            <div class="query-bar">
              <el-form
                :model="query"
                :inline="true"
                ref="queryRef"
                @submit.prevent="submitQuery"
              >
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
                  <el-button type="primary" :icon="Search" native-type="submit">
                    查询
                  </el-button>
                  <el-button :icon="RefreshLeft" @click="resetQuery">重置</el-button>
                </el-form-item>
              </el-form>
            </div>
            <div class="list">
              <el-table
                :data="users"
                v-loading="paginateLoading"
                row-key="id"
                ref="usersRef"
                class="table"
                @selection-change="selectUsers"
                @row-click="selectRow"
              >
                <el-table-column
                  v-slot="{ row }"
                  reserve-selection
                  type="selection"
                  width="50"
                />
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
          </div>
        </flag-title-panel>
      </el-col>
      <el-col :span="8">
        <flag-title-panel title="已选用户">
          <template #action>
            <div class="action">
              <el-button size="small" @click="clearAllSelectedUsers()"
                >清除全部</el-button
              >
            </div>
          </template>
          <div class="selected-user-panel">
            <el-tag
              v-for="user in selectedUsers"
              :key="user.id"
              closable
              class="user"
              @close="deleteSelectedUser(user.id)"
            >
              {{ user.name }}
            </el-tag>

            <el-empty
              description="还没有选择用户，请在左边选择用户"
              v-if="selectedUsers.length === 0"
            />
          </div>
        </flag-title-panel>
      </el-col>
    </el-row>

    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" @click="confirmSelect"> 确定 </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, watch, onMounted, nextTick } from "vue";
import { Search, RefreshLeft } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const props = defineProps({
  modelValue: {
    type: Array,
    default: [],
  },
});
const emits = defineEmits(["close", "confirmed"]);
const userIds = defineModel({
  type: Array,
  default: [],
});
const queryRef = ref();
const query = ref({
  size: 30,
  page: 1,
});
const users = ref([]);
const usersRef = ref(null);
const paginateLoading = ref(false);
const total = ref(0);
const selectedUsers = ref([]);
let settingTableSelected = false; //同步表格选中项时忽略选择事件

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
      "desktop/components.UsersSelectDialog/getPaginate",
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
 * 得到已选用户
 */
const getSelectedUsers = async () => {
  if (userIds.value.length === 0) {
    selectedUsers.value = [];
    return;
  }
  const response = await axios.post(
    "desktop/components.UsersSelectDialog/getSelectedUsers",
    { user_ids: userIds.value },
  );
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  selectedUsers.value = response.data;
};

/**
 * 初始化
 */
const init = async () => {
  await getSelectedUsers();
  await getPaginate();
  await nextTick();
  setTableSelected();
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
 * 选择用户列表
 */
const selectUsers = (users) => {
  if (settingTableSelected) {
    return;
  }
  selectedUsers.value = users;
};

/**
 * 设置表格选中项
 */
const setTableSelected = () => {
  if (!usersRef.value) {
    return;
  }
  const userMap = new Map(users.value.map((user) => [user.id, user]));

  settingTableSelected = true;
  try {
    usersRef.value.clearSelection();
    selectedUsers.value.forEach((user) => {
      usersRef.value.toggleRowSelection(userMap.get(user.id) || user, true);
    });
  } finally {
    settingTableSelected = false;
  }
};

/**
 * 删除已选用户
 * @param id
 */
const deleteSelectedUser = (id) => {
  selectedUsers.value = selectedUsers.value.filter((user) => user.id != id);
  setTableSelected();
};

/**
 * 清除全部
 */
const clearAllSelectedUsers = () => {
  selectedUsers.value = [];
  setTableSelected();
};

/**
 * 切换选择行
 * @param row
 */
const selectRow = (row) => {
  usersRef.value.toggleRowSelection(row);
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
  userIds.value = selectedUsers.value.map((user) => user.id);
  emits("confirmed", selectedUsers.value);
};

watch(
  () => props.modelValue,
  async (newValue) => {
    userIds.value = newValue;
    await getSelectedUsers();
    setTableSelected();
  },
  {
    deep: true,
  },
);

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.users-select-dialog {
  .user-panel {
    .query-bar {
      margin-top: var(--margin);
      .el-select {
        width: 150px;
      }
      .el-input {
        width: 150px;
      }
    }
    .list {
      :deep(th.el-table__cell) {
        background-color: var(--background-color-dark);
      }
      .table {
        height: 300px;
      }
    }
    .pagination {
      margin-top: var(--margin);
    }
  }
  .selected-user-panel {
    .user {
      margin-right: var(--margin);
    }
  }
}
</style>
