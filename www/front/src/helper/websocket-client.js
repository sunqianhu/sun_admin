/**
 * websocket客户端
 */
class WebsocketClient {
  url = "";
  websocketClient = null;
  reconnectInterval = 1000 * 30; //重连间隔
  reconnectFlag = false; //重连标识
  pingTimer = 0; //心跳定时器
  pingInterval = 1000 * 40; //心跳间隔

  //事件
  onOpen = (event) => {}; //打开
  onError = (event) => {}; //错误
  onClose = (event) => {}; //关闭
  onMessage = (event) => {}; //消息

  /**
   * 构造函数
   * @param {*} url
   */
  constructor(url) {
    this.url = url;
  }

  /**
   * 连接
   */
  connect() {
    if (!this.url) {
      throw new Error("还未设置websocket服务端的url");
    }
    if (window.WebSocket) {
      this.websocketClient = new WebSocket(this.url);
    } else if (window.MozWebSocket) {
      this.websocketClient = new MozWebSocket(this.url);
    } else {
      throw new Error("浏览器不支持websocket，推荐使用新版chrome浏览器");
    }

    this.websocketClient.onopen = (event) => {
      console.log("webSocket：onopen 连接成功");
      this.ping();
      this.onOpen(event);
    };
    this.websocketClient.addEventListener("error", (event) => {
      console.log("webSocket：onerror 遇到错误", event);
      this.reconnect();
      this.onError(event);
    });
    this.websocketClient.onclose = (event) => {
      console.log("webSocket：onclose 连接关闭");
      this.reconnect();
      this.onClose(event);
    };
    this.websocketClient.addEventListener("message", (event) => {
      console.log("webSocket：onmessage 收到消息", event);
      this.onMessage(event);
    });
  }

  /**
   * 重连
   */
  reconnect() {
    if (this.reconnectFlag) {
      return;
    }
    if (this.pingTimer) {
      clearInterval(this.pingTimer);
    }
    this.reconnectFlag = true;
    setTimeout(() => {
      console.log("webSocket：断线重连");
      this.connect();
      this.reconnectFlag = false;
    }, this.reconnectInterval);
  }

  /**
   * 心跳
   */
  ping() {
    if (this.pingTimer) {
      clearInterval(this.pingTimer);
    }
    this.pingTimer = setInterval(() => {
      console.log("webSocket：发送心跳");
      this.websocketClient.send('{"type":"ping"}');
    }, this.pingInterval);
  }

  /**
   * 发送
   * @param {string} data
   */
  send(data) {
    return this.websocketClient.send(data);
  }
}

export default WebsocketClient;
