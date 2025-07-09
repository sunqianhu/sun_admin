<template></template>

<script setup>
import { onMounted } from "vue";
import axios from "@/helper/axios";
import audioPath from "@/assets/message.mp3";
import createWebsocketClient from "sunqianhu_websocket_client";

let messageInstances = []; //消息实例
let websocketClient = null;
let url = "";

/**
 * 初始化
 */
const init = () => {
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
    if (data.type == "message") {
      removeFirstMessageIfOverLimit();
      showMessage(data);
      playAudio();
      setRead(data.id);
    }
  };
  websocketClient.connect();
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

/**
 * 设为已读
 */
const setRead = async (id) => {
  await axios.post("desktop/components.PopupMessage/setRead", {
    id: id,
  });
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
 * 移除第一个消息
 */
const removeFirstMessageIfOverLimit = () => {
  if (messageInstances.length < 5) {
    return;
  }
  const firstNotification = messageInstances.pop();
  if (firstNotification) {
    firstNotification.close();
  }
};

/**
 * 显示消息
 */
const showMessage = async (data) => {
  let content = data.content;
  if (data.url) {
    content += ` <a href="${data.url}" target="_blank" style="white-space: nowrap;">【详情】</a>`;
  }
  let messageInstance = ElNotification({
    title: data.title,
    dangerouslyUseHTMLString: true,
    duration: 0,
    message: content,
    position: "bottom-right",
  });

  messageInstances.unshift(messageInstance);
};

/**
 * 播放声音
 */
function playAudio() {
  let audio = new Audio(audioPath);
  audio.play();
}

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.popup-message {
  background-color: var(--background-color-light);
  width: 400px;
  position: fixed;
  right: var(--margin);
  bottom: var(--margin);
  z-index: 3001;
  box-shadow: var(--box-shadow);
  border-radius: var(--border-radius);

  .popup-message__title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--margin) var(--margin) 0px var(--margin);
    .popup-message__close {
      cursor: pointer;
      color: var(--font-color-secondary);
      &:hover {
        color: var(--font-color);
      }
    }
  }
  .popup-message__content {
    .scrollbar {
      padding: var(--padding);
      .item {
        border-bottom: 1px solid var(--border-color);
        padding: var(--padding-sm) 0px;
        &:last-child {
          border-bottom: none;
        }
      }
    }
  }
}
</style>
