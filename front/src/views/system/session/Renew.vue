<template>
  <el-dialog
    :model-value="true"
    title="会话续期"
    width="500"
    align-center
    :draggable="true"
    @close="close"
    class="renew"
  >
    <el-scrollbar v-loading="initLoading" max-height="300px" class="scrollbar">
      <el-form
        :model="session"
        :rules="rules"
        scroll-to-error
        ref="sessionRef"
        label-width="120px"
      >
        <el-form-item label="名称">
          {{ session.name }}
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
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

const props = defineProps(["id"]);
const emits = defineEmits(["close", "submited"]);
const session = ref({});
const sessionRef = ref();
const rules = {
  expire_time: [
    { required: true, message: "请选择过期时间", trigger: "change" },
  ],
};
const initLoading = ref(true);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.session.Renew/init", {
      params: { id: props.id },
    });
  } finally {
    initLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({ message: response.message, type: "error" });
    return;
  }
  session.value = response.data;
  session.value.expire_time = String(session.value.expire_time);
};

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
    response = await axios.post("desktop/system.session.Renew/save", {
      id: props.id,
      expire_time: session.value.expire_time,
    });
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

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.renew {
  .scrollbar {
    padding-right: 30px;
  }
}
</style>
