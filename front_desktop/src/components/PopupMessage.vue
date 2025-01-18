<template></template>

<script setup>
import WebsocketClient from "@/helper/WebsocketClient.js";
import axios from "@/helper/axios";
import audioPath from "@/assets/message.mp3";

let messageInstances = []; //消息实例

//websocket客户端
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
  if (data.type == "message") {
    removeFirstMessageIfOverLimit();
    showMessage(data);
    playAudio();
    setRead(data.id);
  }
};
websocketClient.connect();

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
</script>

<style lang="scss" scoped>
.popup-message {
  background-color: var(--background-color-light);
  width: 400px;
  position: fixed;
  right: var(--margin-md);
  bottom: var(--margin-md);
  z-index: 3001;
  box-shadow: var(--box-shadow-base);
  border-radius: var(--border-radius-md);

  .popup-message__title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--margin-md) var(--margin-md) 0px var(--margin-md);
    .popup-message__close {
      cursor: pointer;
      color: var(--font-color-secondary);
      &:hover {
        color: var(--font-color-base);
      }
    }
  }
  .popup-message__content {
    .scrollbar {
      padding: var(--padding-md);
      .item {
        border-bottom: 1px solid var(--border-color-base);
        padding: var(--padding-xs) 0px;
        &:last-child {
          border-bottom: none;
        }
      }
    }
  }
}
</style>
