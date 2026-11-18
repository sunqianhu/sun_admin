<template>
  <div class="index">
    <div class="page-header">
      <div class="page-header__name">会话管理</div>
      <div class="page-header__description">
        管理桌面端、移动端和 API 端的会话
      </div>
    </div>
    <div class="query-bar">
      <el-form :model="query" :inline="true" ref="queryRef">
        <el-form-item label="终端" prop="terminal">
          <dictionary-select
            v-model="query.terminal"
            type="terminal"
          ></dictionary-select>
        </el-form-item>
        <el-form-item label="是否过期" prop="is_expired">
          <el-select v-model="query.is_expired" placeholder="全部" clearable>
            <el-option label="未过期" :value="0" />
            <el-option label="已过期" :value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="名称" prop="name">
          <el-input v-model="query.name" clearable />
        </el-form-item>
        <el-form-item label="所属用户" prop="user_keyword">
          <el-input
            v-model="query.user_keyword"
            placeholder="姓名或账号"
            clearable
          />
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
      <el-button type="primary" :icon="Plus" @click="openAdd"> 添加 </el-button>
      <el-button
        :loading="deleteExpiredLoading"
        @click="deleteExpired"
        v-permission="['session_delete']"
      >
        删除过期会话
      </el-button>
    </div>

    <div class="list">
      <el-table
        :data="sessions"
        v-loading="paginateLoading"
        row-key="id"
        class="table"
      >
        <el-table-column prop="terminal_name" label="终端" width="100" />
        <el-table-column
          prop="name"
          label="名称"
          width="150"
          show-overflow-tooltip
        />
        <el-table-column v-slot="{ row }" label="所属用户" width="120">
          <a
            :href="'/system/user/detail-' + row.user_id"
            target="_blank"
            v-if="row.user_name"
          >
            {{ row.user_name }}
          </a>
          <span v-else>已删除（ID：{{ row.user_id }}）</span>
        </el-table-column>
        <el-table-column v-slot="{ row }" prop="token" label="令牌">
          <div class="token">
            <el-tooltip :content="row.token" placement="top">
              <div class="token__value">{{ row.token }}</div>
            </el-tooltip>
            <el-button link type="primary" @click="copyToken(row.token)">
              复制
            </el-button>
          </div>
        </el-table-column>
        <el-table-column
          v-slot="{ row }"
          prop="expire_time"
          label="过期时间"
          width="220"
        >
          {{ dayjs.unix(row.expire_time).format("YYYY-MM-DD HH:mm:ss") }}
          <el-text
            type="danger"
            size="small"
            v-if="row.expire_time <= dayjs().unix()"
          >
            已过期
          </el-text>
        </el-table-column>
        <el-table-column
          v-slot="{ row }"
          label="操作"
          fixed="right"
          width="150"
        >
          <el-button size="small" @click="openRenew(row.id)">续期</el-button>
          <el-popconfirm
            title="确定删除该会话吗？删除后将立即失效。"
            width="260"
            @confirm="del(row.id)"
          >
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
        v-model:page-size="query.size"
        v-model:current-page="query.page"
        :total="total"
        @size-change="changePaginationSize"
        @current-change="changePaginationCurrent"
      />
    </div>

    <add
      @close="addFlag = false"
      @submited="
        query.page = 1;
        getPaginate();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <renew
      :id="rowId"
      @close="renewFlag = false"
      @submited="
        getPaginate();
        renewFlag = false;
      "
      v-if="renewFlag"
    ></renew>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search, RefreshLeft, Plus } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import Add from "./Add.vue";
import Renew from "./Renew.vue";
import DictionarySelect from "@/components/DictionarySelect.vue";

const queryRef = ref();
const query = ref({
  name: "",
  user_keyword: "",
  terminal: "",
  is_expired: "",
  size: 30,
  page: 1,
});
const sessions = ref([]);
const paginateLoading = ref(true);
const total = ref(0);
const rowId = ref(0);
const addFlag = ref(false);
const renewFlag = ref(false);
const deleteExpiredLoading = ref(false);

/**
 * 获取分页
 */
const getPaginate = async () => {
  paginateLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.session.Index/getPaginate", {
      params: query.value,
    });
  } finally {
    paginateLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({ message: response.message, type: "error" });
    return;
  }
  sessions.value = response.data.data;
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
 * @param {number} page
 */
const changePaginationCurrent = (page) => {
  query.value.page = page;
  getPaginate();
};

/**
 * 打开添加会话
 */
const openAdd = () => {
  addFlag.value = true;
};

/**
 * 打开会话续期
 * @param {number} id
 */
const openRenew = (id) => {
  rowId.value = id;
  renewFlag.value = true;
};

/**
 * 删除会话
 * @param {number} id
 */
const del = async (id) => {
  const response = await axios.post("desktop/system.session.Index/delete", {
    id: id,
  });
  if (response.code != 0) {
    ElMessage({ message: response.message, type: "error" });
    return;
  }
  ElMessage({ message: response.message, type: "success" });
  if (sessions.value.length === 1 && query.value.page > 1) {
    query.value.page -= 1;
  }
  getPaginate();
};

/**
 * 删除过期会话
 */
const deleteExpired = async () => {
  await ElMessageBox.confirm(
    "确定删除桌面端、移动端和API端的全部过期会话吗？",
    "提示",
    { type: "warning", draggable: true },
  );
  deleteExpiredLoading.value = true;
  let response;
  try {
    response = await axios.post("desktop/system.session.Index/deleteExpired");
  } finally {
    deleteExpiredLoading.value = false;
  }
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
  query.value.page = 1;
  getPaginate();
};

/**
 * 复制令牌
 * @param {string} token
 */
const copyToken = async (token) => {
  try {
    if (navigator.clipboard && window.isSecureContext) {
      await navigator.clipboard.writeText(token);
    } else {
      const textarea = document.createElement("textarea");
      textarea.value = token;
      textarea.style.position = "fixed";
      textarea.style.opacity = "0";
      document.body.appendChild(textarea);
      try {
        textarea.select();
        if (!document.execCommand("copy")) {
          throw new Error("复制失败，请手动复制令牌");
        }
      } finally {
        textarea.remove();
      }
    }
    ElMessage({ message: "复制成功", type: "success" });
  } catch (error) {
    ElMessage({ message: "复制失败，请手动复制令牌", type: "error" });
  }
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
  .list {
    margin-top: var(--margin);
    :deep(th.el-table__cell) {
      background-color: var(--background-color-lighter);
    }
    .table {
      width: 100%;
    }
    .token {
      display: flex;
      align-items: center;
      gap: var(--margin-sm);
      .token__value {
        flex: 1;
        min-width: 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }
      .el-button {
        flex-shrink: 0;
      }
    }
  }
  .pagination {
    margin-top: var(--margin);
  }
}
</style>
