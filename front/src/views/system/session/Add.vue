<template>
  <el-dialog
    :model-value="true"
    title="添加会话"
    width="560"
    align-center
    :draggable="true"
    class="add"
    @close="close"
  >
    <el-scrollbar max-height="400px" class="scrollbar">
      <el-form
        :model="session"
        :rules="rules"
        scroll-to-error
        ref="sessionRef"
        label-width="120px"
      >
        <el-form-item label="终端" prop="terminal">
          <dictionary-select
            v-model="session.terminal"
            type="terminal"
          ></dictionary-select>
        </el-form-item>
        <el-form-item label="名称" prop="name">
          <el-input
            v-model="session.name"
            maxlength="63"
            show-word-limit
            placeholder="留空使用默认名称"
          />
        </el-form-item>
        <el-form-item label="所属用户" prop="user_id">
          <user-select v-model="session.user_id"></user-select>
        </el-form-item>
        <el-form-item label="过期时间" prop="expire_time">
          <el-date-picker
            v-model="session.expire_time"
            type="datetime"
            format="YYYY-MM-DD HH:mm:ss"
            value-format="X"
            placeholder="请选择过期时间"
          />
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" :loading="submitLoading" @click="submitForm">
        提交
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import UserSelect from "@/components/UserSelect.vue";
import DictionarySelect from "@/components/DictionarySelect.vue";

const emits = defineEmits(["close", "submited"]);
const session = ref({
  name: "",
  terminal: "",
  user_id: 0,
  expire_time: String(dayjs().add(1, "month").unix()),
});
const sessionRef = ref();
const rules = {
  terminal: [{ required: true, message: "请选择终端", trigger: "change" }],
  user_id: [{ required: true, message: "请选择所属用户", trigger: "change" }],
  expire_time: [
    { required: true, message: "请选择过期时间", trigger: "change" },
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
  await sessionRef.value.validate();
  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.session.Add/save",
      session.value,
    );
  } finally {
    submitLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({ message: response.message, type: "error" });
    return;
  }
  ElMessage({ message: response.message, type: "success" });
  emits("submited", true);
};
</script>

<style lang="scss" scoped>
.add {
  .scrollbar {
    padding-right: 30px;
  }
}
</style>
