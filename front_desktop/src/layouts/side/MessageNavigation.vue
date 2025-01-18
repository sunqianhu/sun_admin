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
import WebsocketClient from "@/helper/WebsocketClient.js";
import axios from "@/helper/axios";
import { ChatDotRound } from "@element-plus/icons-vue";

const router = useRouter();
const websocketClient = new WebsocketClient(
  import.meta.env.VITE_WEBSOCKET_MESSAGE
);
websocketClient.onOpen = () => {
  bind();
};
websocketClient.onMessage = (event) => {
  const data = JSON.parse(event.data);
  if (!data) {
    throw new Error("消息格式错误，消息：" + event.data);
  }
  if (data.type == "read" || data.type == "all_read") {
    getNoReadCount();
  }
};
websocketClient.connect();
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

/**
 * 绑定用户
 */
const bind = () => {
  let token = localStorage.getItem("token");
  if (!token) {
    throw new Error("建立连接时token不能为空");
  }
  const data = {
    type: "bind",
    token: token,
  };
  const dataString = JSON.stringify(data);
  websocketClient.send(dataString);
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
