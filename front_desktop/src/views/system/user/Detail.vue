<template>
  <div class="detail" v-loading="loading">
    <panel title="用户信息" class="pannel">
      <label-value>
        <label-value-item label="用户id" :md="8">{{ user.id }}</label-value-item>
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
          {{ dayjs.unix(user.login_time).format("YYYY-MM-DD HH:mm:ss") }}
        </label-value-item>
        <label-value-item label="最后登录ip" :md="8">{{ user.login_ip }}</label-value-item>
      </label-value>
    </panel>

    <panel title="登录日志" class="pannel">
      <template #actions>
        <el-link href="/system/login_log" type="primary" target="_blank"> 更多 </el-link>
      </template>
      <el-table :data="loginLogs" row-key="id" style="width: 100%">
        <el-table-column prop="ip" label="登录ip" />
        <el-table-column label="登录时间" v-slot="{ row }">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
      </el-table>
    </panel>

    <panel title="操作日志" class="pannel">
      <template #actions>
        <el-link href="/system/operation_log" type="primary" target="_blank"> 更多 </el-link>
      </template>
      <el-table :data="operationLogs" row-key="id" style="width: 100%">
        <el-table-column label="操作时间" v-slot="{ row }">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
        <el-table-column prop="url" label="操作地址" width="450" />
        <el-table-column prop="ip" label="操作ip" />
      </el-table>
    </panel>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "@/helper/axios";
import Panel from "@/components/Panel.vue";
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
  loginLogs.value = response.data.login - logs;
  operationLogs.value = response.data.operation - logs;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.detail {
  padding: var(--padding-md);
  .pannel {
    margin-top: var(--margin-md);
    &:first-child {
      margin-top: 0px;
    }
  }
}
</style>
