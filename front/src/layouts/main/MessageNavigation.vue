<template>
  <div class="message-navigation" @click="router.push('/system/message')">
    <el-badge :value="noReadCount" :max="99" :hidden="noReadCount <= 0">
      <el-tooltip effect="dark" content="查看系统消息" placement="bottom">
        <el-icon class="icon"><ChatDotRound /></el-icon>
      </el-tooltip>
    </el-badge>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import axios from "@/helper/axios";
import { ChatDotRound } from "@element-plus/icons-vue";

const router = useRouter();
const noReadCount = ref(0);

/**
 * 得到未读数
 */
const getNoReadCount = async () => {
  const response = await axios.get(
    "desktop/layouts.main.MessageNavigation/getNoReadCount"
  );
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  noReadCount.value = response.data;
};

onMounted(() => {
  getNoReadCount();
});
</script>

<style lang="scss" scoped>
.message-navigation {
  line-height: 0px;
  cursor: pointer;
  .icon {
    font-size: 20px;
  }
  &:hover {
    .icon {
      animation: twinkle 0.3s ease-in-out;
    }
  }
}

@keyframes twinkle {
  0% {
    transform: scale(0);
  }
  80% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
  }
}
</style>
