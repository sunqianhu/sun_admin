<template>
  <div class="detail" v-loading="initLoading">
    <card-panel title="用户信息" class="panel">
      <attribute-list>
        <attribute label="用户ID" :md="8">
          {{ user.id }}
        </attribute>
      </attribute-list>
    </card-panel>

    <card-panel title="登录日志" class="panel">
      <template #action>
        <el-link href="/system/login_log" type="primary" target="_blank">
          更多
        </el-link>
      </template>
      <el-table :data="loginLogs" row-key="id" style="width: 100%">
        <el-table-column prop="ip" label="登录ip" />
      </el-table>
    </card-panel>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "@/helper/axios";
import CardPanel from "@/components/CardPanel.vue";
import AttributeList from "@/components/AttributeList.vue";
import Attribute from "@/components/Attribute.vue";

const route = useRoute();
const initLoading = ref(true);
const user = ref({});
const loginLogs = ref([]);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/dictionary.Detail/init", {
      params: { id: route.params.id },
    });
  } finally {
    initLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  user.value = response.data.user;
  loginLogs.value = response.data.login_logs;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.detail {
  padding: var(--padding);
  .panel {
    margin-top: var(--margin);
    &:first-child {
      margin-top: 0px;
    }
  }
}
</style>
