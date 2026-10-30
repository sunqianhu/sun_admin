<template>
  <el-dialog
    :model-value="true"
    title="操作日志详情"
    width="900"
    align-center
    :draggable="true"
    class="detail"
    @close="close"
  >
    <el-scrollbar v-loading="initLoading" max-height="500" class="scrollbar">
      <div v-if="operationLog.id">
        <attribute-list>
          <attribute label="日志ID" :span="12">
            {{ operationLog.id }}
          </attribute>
          <attribute label="终端" :span="12">
            {{ operationLog.terminal_name }}
          </attribute>
          <attribute label="用户姓名" :span="12">
            {{ operationLog.user_name }}
          </attribute>
          <attribute label="所属部门" :span="12">
            {{ operationLog.department_name }}
          </attribute>
          <attribute label="操作IP" :span="12">
            {{ operationLog.ip }}
          </attribute>
          <attribute label="操作时间" :span="12">
            {{ dayjs.unix(operationLog.time).format("YYYY-MM-DD HH:mm:ss") }}
          </attribute>
          <attribute label="请求方法" :span="24">
            {{ operationLog.request_method }}
          </attribute>
          <attribute label="请求接口" :span="24">
            {{ operationLog.api }}
          </attribute>
        </attribute-list>
        <div class="request-content">
          <div class="request-content__label">请求内容</div>
          <pre class="request-content__value">{{
            operationLog.request_content || "无请求内容"
          }}</pre>
        </div>
      </div>
    </el-scrollbar>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import AttributeList from "@/components/AttributeList.vue";
import Attribute from "@/components/Attribute.vue";

const props = defineProps(["id"]);
const emits = defineEmits(["close"]);
const operationLog = ref({});
const initLoading = ref(true);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.operation_log.Detail/init", {
      params: { id: props.id },
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
  operationLog.value = response.data;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.detail {
  .scrollbar {
    min-height: 200px;
    .request-content {
      margin-top: var(--margin);
      .request-content__label {
        margin-bottom: var(--margin-sm);
        color: var(--font-color-secondary);
      }
      .request-content__value {
        padding: var(--padding);
        border-radius: var(--border-radius);
        background-color: var(--background-color-lighter);
      }
    }
  }
}
</style>
