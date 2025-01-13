<template>
  <el-collapse-transition>
    <div class="message" v-if="show">
      <div class="title">
        <div class="name">消息提醒</div>
        <el-icon class="close" @click="close"><Close /></el-icon>
      </div>
      <div class="content">
        <el-scrollbar max-height="300px" class="scrollbar">
          <div
            class="item"
            v-for="(message, index) in messages"
            :key="message.id"
          >
            <a href="javascript:;" @click="navigateTo(index, message.url)">
              {{ message.title }}
            </a>
          </div>
        </el-scrollbar>
      </div>
    </div>
  </el-collapse-transition>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Close } from "@element-plus/icons-vue";
import WebsocketClient from "@/helper/WebsocketClient.js";
import axios from "@/helper/axios";
import audioPath from "@/assets/message.mp3";

const messages = ref([]); //消息
const show = ref(false); //显示

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
    return;
  }
  if (data.type == "message") {
    showMessage(data);
  }
};
websocketClient.connect();

/**
 * 获取未读消息
 */
const getNoReadMessages = async () => {
  const response = await axios.get("desktop/frame.Message/getNoReadMessages");
  if (response.code != 1) {
    return;
  }
  if (response.data.length == 0) {
    return;
  }
  messages.value = response.data;
  show.value = true;
};

/**
 * 设置全部已读
 */
const setAllRead = async () => {
  await axios.get("desktop/frame.Message/setAllRead");
};

/**
 * 绑定用户
 */
const bind = () => {
  const data = {
    type: "bind",
    token: localStorage.getItem("token"),
  };
  const dataString = JSON.stringify(data);
  websocketClient.send(dataString);
};

/**
 * 显示消息
 */
const showMessage = async (data) => {
  show.value = true;
  const message = {
    title: data.title,
    url: data.url,
  };
  messages.value.unshift(message);
  playAudio();
  setAllRead();
};

/**
 * 关闭
 */
const close = async () => {
  messages.value = [];
  show.value = false;
  setAllRead();
};

/**
 * 导航
 * @param {string} url 路由地址
 */
const navigateTo = (index, url) => {
  messages.value.splice(index, 1);
  if (messages.value.length <= 0) {
    show.value = false;
  }

  if (!url) {
    return;
  }
  //router.push(url);
  window.open(url);
};

/**
 * 播放声音
 */
function playAudio() {
  let audio = new Audio(audioPath);
  audio.play();
}

onMounted(() => {
  getNoReadMessages();
});
</script>

<style lang="scss" scoped>
.message {
  background-color: var(--background-color-light);
  width: 400px;
  position: absolute;
  right: var(--margin-md);
  bottom: var(--margin-md);
  z-index: 3001;
  box-shadow: var(--box-shadow-base);
  border-radius: var(--border-radius-md);

  .title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--margin-md) var(--margin-md) 0px var(--margin-md);
    .close {
      cursor: pointer;
      color: var(--font-color-secondary);
      &:hover {
        color: var(--font-color-base);
      }
    }
  }
  .content {
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
