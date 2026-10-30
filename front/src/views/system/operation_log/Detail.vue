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
          <attribute label="会话ID" :span="12">
            {{ operationLog.session_id }}
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
          <attribute label="处理结果" :span="12">
            <el-tag type="success" v-if="operationLog.result_code == 0">
              成功
            </el-tag>
            <el-tag type="danger" v-else> 失败 </el-tag>
          </attribute>
          <attribute label="结果码" :span="12">
            {{ operationLog.result_code }}
          </attribute>
          <attribute label="处理耗时" :span="24">
            {{ operationLog.duration + " ms" }}
          </attribute>
          <attribute label="请求方法" :span="24">
            {{ operationLog.request_method }}
          </attribute>
          <attribute label="请求接口" :span="24">
            {{ operationLog.api }}
          </attribute>
        </attribute-list>
        <div class="content">
          <div class="content__label">请求内容</div>
          <pre class="content__value">{{
            operationLog.request_content || "无请求内容"
          }}</pre>
        </div>
        <div class="content">
          <div class="content__label">结果内容</div>
          <pre class="content__value">{{ operationLog.result_content }}</pre>
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
    .content {
      margin-top: var(--margin);
      .content__label {
        margin-bottom: var(--margin-sm);
        color: var(--font-color-secondary);
      }
      .content__value {
        padding: var(--padding);
        border-radius: var(--border-radius);
        background-color: var(--background-color-lighter);
      }
    }
  }
}
</style>
