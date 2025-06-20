<template>
  <el-dialog
    :model-value="true"
    title="账号信息"
    width="500"
    :draggable="true"
    @close="close"
    class="detail"
  >
    <div v-loading="dialogLoading">
      <attribute-list>
        <attribute label="账号" :span="24">{{ user.account }}</attribute>
        <attribute label="姓名" :span="24">{{ user.name }}</attribute>
        <attribute label="手机号码" :span="24">{{ user.phone }}</attribute>
        <attribute label="所属部门" :span="24">
          {{ user.department_name }}
        </attribute>
        <attribute label="最后登录时间" :span="24">
          {{ dayjs.unix(user.last_login_time).format("YYYY-MM-DD HH:mm:ss") }}
        </attribute>
        <attribute label="最后登录ip" :span="24">
          {{ user.last_login_ip }}
        </attribute>
      </attribute-list>
    </div>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import AttributeList from "@/components/AttributeList.vue";
import Attribute from "@/components/Attribute.vue";

const emits = defineEmits(["close"]);
const dialogLoading = ref(false);
const user = ref({});

/**
 * 初始化
 */
const init = async () => {
  dialogLoading.value = true;
  const response = await axios.get("desktop/layouts.main.user.Detail/getUser");
  dialogLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
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
.detail {
}
</style>
