<template>
  <el-dialog
    :model-value="true"
    title="删除操作日志"
    width="550"
    align-center
    :draggable="true"
    class="time-range-delete"
    @close="close"
  >
    <div>
      <el-alert
        title="将删除所选时间段内所有终端的操作日志，包含起止时间。"
        type="warning"
        show-icon
        :closable="false"
      />
    </div>
    <el-form
      :model="timeRangeDelete"
      :rules="rules"
      ref="timeRangeDeleteRef"
      label-width="100px"
      class="form"
    >
      <el-form-item label="操作时间" prop="times">
        <el-date-picker
          v-model="timeRangeDelete.times"
          type="datetimerange"
          format="YYYY-MM-DD HH:mm:ss"
          value-format="X"
          range-separator="至"
          start-placeholder="开始时间"
          end-placeholder="结束时间"
          unlink-panels
        />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="close" :disabled="submitLoading">取消</el-button>
      <el-button type="primary" :loading="submitLoading" @click="submitForm">
        删除
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref } from "vue";
import dayjs from "dayjs";
import axios from "@/helper/axios";

const emits = defineEmits(["close", "submited"]);
const timeRangeDelete = ref({ times: [] });
const timeRangeDeleteRef = ref();
const rules = {
  times: [
    {
      required: true,
      type: "array",
      len: 2,
      message: "请选择完整的操作时间段",
      trigger: "change",
    },
  ],
};
const submitLoading = ref(false);

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await timeRangeDeleteRef.value.validate();

  const times = timeRangeDelete.value.times.map(Number);
  const startTime = dayjs.unix(times[0]).format("YYYY-MM-DD HH:mm:ss");
  const endTime = dayjs.unix(times[1]).format("YYYY-MM-DD HH:mm:ss");
  await ElMessageBox.confirm(
    "确定删除" + startTime + "到" + endTime + "这些操作日志吗？",
    "提示",
    { type: "warning", draggable: true },
  );

  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.operation_log.TimeRangeDelete/save",
      { start_time: times[0], end_time: times[1] },
    );
  } finally {
    submitLoading.value = false;
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
  emits("submited", true);
};
</script>

<style lang="scss" scoped>
.time-range-delete {
  .form {
    margin-top: var(--margin);
  }
}
</style>
