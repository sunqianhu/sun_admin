<template>
  <el-dialog
    :model-value="open"
    title="账号信息"
    width="500"
    :draggable="true"
    v-loading="dialogLoading"
    @close="handleClose"
    class="info"
  >
    <label-values>
      <label-value label="账号" sm="24" md="24" lg="24">{{ user.account }}</label-value>
      <label-value label="姓名" sm="24" md="24" lg="24">{{ user.name }}</label-value>
      <label-value label="手机号码" sm="24" md="24" lg="24">{{ user.phone }}</label-value>
      <label-value label="所属部门" sm="24" md="24" lg="24">
        {{ user.department_name }}
      </label-value>
      <label-value label="最后登录时间" sm="24" md="24" lg="24">
        {{ dayjs.unix(user.login_time).format("YYYY-MM-DD HH:mm:ss") }}
      </label-value>
      <label-value label="最后登录ip" sm="24" md="24" lg="24">{{ user.login_ip }}</label-value>
    </label-values>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import LabelValues from "@/components/LabelValues.vue";
import LabelValue from "@/components/LabelValue.vue";

const props = defineProps(["open"]);
const emits = defineEmits(["close"]);
const dialogLoading = ref(false);
const user = ref({});

/**
 * 初始化
 */
const init = async () => {
  dialogLoading.value = true;
  const response = await axios.get("desktop/My/info");
  dialogLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  user.value = response.data;
};

/**
 * 处理关闭
 */
const handleClose = () => {
  emits("close", true);
};

onMounted(() => {
  init();
});
</script>
<style lang="scss" scoped>
.info {
  .field-wrap {
    .field {
      margin-top: 8px;
      &:first-child {
        margin-top: 0px;
      }
      .label {
        color: var(--font-color-secondary);
        width: 100px;
        display: inline-block;
      }
      .content {
        display: inline-block;
        margin-left: 16px;
      }
    }
  }
}
</style>
