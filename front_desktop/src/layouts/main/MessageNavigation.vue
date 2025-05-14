<template>
  <div class="message-navigation">
    <el-badge :value="noReadCount" :max="99" :hidden="noReadCount <= 0">
      <el-tooltip effect="dark" content="系统消息" placement="bottom">
        <ChatDotRound
          class="message-navigation__icon"
          @click="router.push('/system/message')"
        />
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
    "desktop/layouts.side.MessageNavigation/getNoReadCount"
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
  .message-navigation__icon {
    width: 20px;
    height: 20px;
    cursor: pointer;
    &:hover {
      opacity: var(--active-opacity);
    }
  }
}
</style>
