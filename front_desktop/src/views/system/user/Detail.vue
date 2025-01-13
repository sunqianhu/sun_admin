<template>
  <div class="detail" v-loading="loading">
    <card-panel title="用户信息" class="panel">
      <label-value>
        <label-value-item label="用户ID" :md="8">{{ user.id }}</label-value-item>
        <label-value-item label="账号" :md="8">{{ user.account }}</label-value-item>
        <label-value-item label="姓名" :md="8">{{ user.name }}</label-value-item>
        <label-value-item label="手机号码" :md="8">{{ user.phone }}</label-value-item>
        <label-value-item label="部门" :md="8">{{ user.department?.name }}</label-value-item>
        <label-value-item label="角色" :md="8">{{ user.role_name_string }}</label-value-item>
        <label-value-item label="状态" :md="8">{{ user.status_name }}</label-value-item>
        <label-value-item label="添加时间" :md="8">
          {{ dayjs.unix(user.add_time).format("YYYY-MM-DD HH:mm:ss") }}
        </label-value-item>
        <label-value-item label="最后修改时间" :md="8">
          {{ dayjs.unix(user.edit_time).format("YYYY-MM-DD HH:mm:ss") }}
        </label-value-item>
        <label-value-item label="最后登录时间" :md="8">
          {{ dayjs.unix(user.last_login_time).format("YYYY-MM-DD HH:mm:ss") }}
        </label-value-item>
        <label-value-item label="最后登录ip" :md="8">{{ user.last_login_ip }}</label-value-item>
      </label-value>
    </card-panel>

    <card-panel title="登录日志" class="panel">
      <template #actions>
        <el-link href="/system/login-log" type="primary" target="_blank"> 更多 </el-link>
      </template>
      <el-table :data="loginLogs" row-key="id" style="width: 100%">
        <el-table-column prop="ip" label="登录ip" />
        <el-table-column label="登录时间" v-slot="{ row }">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
      </el-table>
    </card-panel>

    <card-panel title="操作日志" class="panel">
      <template #actions>
        <el-link href="/system/operation-log" type="primary" target="_blank"> 更多 </el-link>
      </template>
      <el-table :data="operationLogs" row-key="id" style="width: 100%">
        <el-table-column label="操作时间" v-slot="{ row }">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
        <el-table-column prop="api" label="请求接口" width="450" />
        <el-table-column prop="ip" label="操作ip" />
      </el-table>
    </card-panel>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "@/helper/axios";
import CardPanel from "@/components/CardPanel.vue";
import LabelValue from "@/components/LabelValue.vue";
import LabelValueItem from "@/components/LabelValueItem.vue";
import dayjs from "dayjs";

const route = useRoute();
const user = ref({});
const loginLogs = ref([]);
const operationLogs = ref([]);
const loading = ref(true);

/**
 * 初始化
 */
const init = async () => {
  loading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.user.Detail/init", {
      params: { id: route.params.id }
    });
  } catch (error) {
    loading.value = false;
    return;
  }
  loading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  user.value = response.data.user;
  loginLogs.value = response.data.login_logs;
  operationLogs.value = response.data.operation_logs;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.detail {
  padding: var(--padding-md);
  .panel {
    margin-top: var(--margin-md);
    &:first-child {
      margin-top: 0px;
    }
  }
}
</style>
