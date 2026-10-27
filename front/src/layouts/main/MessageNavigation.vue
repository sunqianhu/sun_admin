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
import { ref, onMounted, onBeforeUnmount } from "vue";
import { useRouter } from "vue-router";
import axios from "@/helper/axios";
import { ChatDotRound } from "@element-plus/icons-vue";
import createWebsocketClient from "sunqianhu_websocket_client";

const router = useRouter();
const noReadCount = ref(0);
let websocketClient = null;

/**
 * 初始化
 */
const init = () => {
  initWebsocketClient();
  getNoReadCount();
};

/**
 * 初始化websocket client
 */
const initWebsocketClient = () => {
  let url = getWsUrl();
  websocketClient = createWebsocketClient(url);
  websocketClient.onOpen = () => {
    bind();
  };
  websocketClient.onMessage = (event) => {
    const data = JSON.parse(event.data);
    if (!data) {
      throw new Error("消息格式错误，消息：" + event.data);
    }
    if (data.type == "all_read") {
      getNoReadCount();
    }
  };
  websocketClient.connect();
};

/**
 * 得到未读数
 */
const getNoReadCount = async () => {
  const response = await axios.get(
    "desktop/layouts.main.MessageNavigation/getNoReadCount",
  );
  if (response.code != 0) {
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

/**
 * 获取websocket连接地址
 */
const getWsUrl = () => {
  let url = import.meta.env.VITE_WEBSOCKET_MESSAGE_URL;
  if (!url.startsWith("ws")) {
    const hostname = window.location.hostname;
    const protocol =
      window.location.protocol.indexOf("https") === 0 ? "wss://" : "ws://";
    const port = window.location.port;
    url = protocol + hostname + (port ? ":" + port : "") + url;
  }
  return url;
};

onMounted(() => {
  init();
});

onBeforeUnmount(() => {
  websocketClient.close();
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
