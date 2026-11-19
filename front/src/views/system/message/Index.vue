<template>
  <div class="index">
    <page-header>
      系统消息
      <template #subtitle>查看系统通知和消息内容</template>
    </page-header>
    <div class="query-bar">
      <el-form
        :model="query"
        :inline="true"
        ref="queryRef"
        @submit.prevent="submitQuery"
      >
        <el-form-item label="消息时间" prop="times">
          <el-date-picker
            v-model="query.times"
            type="datetimerange"
            format="YYYY-MM-DD HH:mm:ss"
            value-format="X"
            range-separator="至"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
            editable
            unlink-panels
          />
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
      <div v-for="message in messages" class="message">
        <div class="message__header">
          <span class="message__title">{{ message.title }}</span>
          <span v-if="!message.is_read" class="message__no-read">【未读】</span>
          <span class="message__time">
            {{ dayjs.unix(message.add_time).format("YYYY-MM-DD HH:mm:ss") }}
          </span>
        </div>
        <div class="message__content">
          {{ message.content }}
          <span>
            <a
              :href="message.url"
              target="_blank"
              rel="noopener noreferrer"
              v-if="message.url"
            >
              【详情】
            </a>
          </span>
        </div>
      </div>
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
</template>

<script setup>
import { ref, onMounted } from "vue";
import dayjs from "dayjs";
import { Search, RefreshLeft } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const queryRef = ref();
const query = ref({
  times: [],
  size: 30,
  page: 1,
});
const messages = ref([]);
const paginateLoading = ref(true);
const total = ref(0);

/**
 * 得到分页
 */
const getPaginate = async () => {
  paginateLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.message.Index/getPaginate", {
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

  total.value = response.data.total;
  messages.value = response.data.data;
};

/**
 * 设为全部已读
 */
const setAllRead = async (id) => {
  await axios.get("desktop/system.message.Index/setAllRead");
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
 * 处理分页当前页改变
 * @param {number} page
 */
const changePaginationCurrent = (page) => {
  query.value.page = page;
  getPaginate();
};

onMounted(() => {
  getPaginate();
  setAllRead();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-page);
  padding: var(--padding);
  border-radius: var(--border-radius);
  .query-bar {
    margin-top: var(--margin);
  }
  .list {
    .message {
      padding: var(--padding);
      border-bottom: 1px solid var(--border-color);
      .message__header {
        .message__no-read {
          color: var(--color-danger);
        }
        .message__title {
          font-size: var(--font-size-lg);
          font-weight: var(--font-weight-bold);
        }
        .message__time {
          margin-left: var(--margin);
          color: var(--font-color-secondary);
        }
      }
      .message__content {
        margin-top: var(--margin);
      }
    }
  }
  .pagination {
    margin-top: var(--margin);
  }
}
</style>
