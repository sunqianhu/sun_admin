<template>
  <el-dialog
    :model-value="open"
    title="账号信息"
    width="500"
    :draggable="true"
    @close="close"
    class="info"
  >
    <div v-loading="dialogLoading">
      <label-value>
        <label-value-item label="账号" :sm="24">{{ user.account }}</label-value-item>
        <label-value-item label="姓名" :sm="24">{{ user.name }}</label-value-item>
        <label-value-item label="手机号码" :sm="24">{{ user.phone }}</label-value-item>
        <label-value-item label="所属部门" :sm="24">
          {{ user.department_name }}
        </label-value-item>
        <label-value-item label="最后登录时间" :sm="24">
          {{ dayjs.unix(user.login_time).format("YYYY-MM-DD HH:mm:ss") }}
        </label-value-item>
        <label-value-item label="最后登录ip" :sm="24">{{ user.login_ip }}</label-value-item>
      </label-value>
    </div>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import LabelValue from "@/components/LabelValue.vue";
import LabelValueItem from "@/components/LabelValueItem.vue";

const props = defineProps(["open"]);
const emits = defineEmits(["close"]);
const dialogLoading = ref(false);
const user = ref({});

/**
 * 初始化
 */
const init = async () => {
  dialogLoading.value = true;
  const response = await axios.get("desktop/layouts.side.user.Detail/getUser");
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
.info {
}
</style>
