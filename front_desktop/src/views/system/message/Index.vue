<template>
  <div class="index">
    <div class="page-name">系统消息</div>
    <div class="searchbar">
      <el-form :model="query" :inline="true">
        <el-form-item label="消息时间">
          <el-date-picker
            v-model="query.time"
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
          <el-button type="primary" :icon="Search" @click="search">
            搜索
          </el-button>
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
            <a :href="message.url" target="_blank" v-if="message.url !== ''">
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
import { Search } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const query = ref({
  time: [],
  size: 30,
  page: 1,
});
const messages = ref([]);
const listLoading = ref(true);
const total = ref(0);

/**
 * 得到系统消息分页
 */
const getMessagePaginate = async () => {
  listLoading.value = true;
  const response = await axios.get(
    "desktop/system.message.Index/getMessagePaginate",
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
  messages.value = response.data.data;
};

/**
 * 设为全部已读
 */
const setAllRead = async (id) => {
  await axios.get("desktop/system.message.Index/setAllRead");
};

/**
 * 搜索
 */
const search = () => {
  getMessagePaginate();
};

/**
 * 改变分页显示条数
 * @param {number} size
 */
const changePaginationSize = (size) => {
  query.value.size = size;
  query.value.number = 1;
  getMessagePaginate();
};

/**
 * 处理分页当前页改变
 * @param {number} page
 */
const changePaginationCurrent = (page) => {
  query.value.page = page;
  getMessagePaginate();
};

onMounted(() => {
  getMessagePaginate();
  setAllRead();
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
