/**
 * websocket客户端
 */
function WebsocketClient(url) {
  this.url = url;
  this.websocketClient = null;
  this.reconnetInterval = 1000 * 10; //重连间隔
  this.reconnetFlag = false; //重连标识
  this.pingTimer = 0; //心跳定时器
  this.pingInterval = 1000 * 40; //心跳间隔

  //事件
  this.onOpen; //打开
  this.onError; //错误
  this.onClose; //关闭
  this.onMessage; //消息

  /**
   * 连接
   * @returns
   */
  this.connect = function () {
    var that = this;

    if (!that.url) {
      throw new Error("请设置websocket服务端的url");
    }

    if (window.WebSocket) {
      that.websocketClient = new WebSocket(that.url);
    } else if (window.MozwebSocket) {
      that.websocketClient = new MozwebSocket(that.url);
    } else {
      throw new Error("浏览器不支持websocket，推荐使用新版chrome浏览器");
    }

    that.websocketClient.onopen = function (event) {
      console.log("webSocket：onopen 连接成功");
      that.ping();
      if (that.onOpen) {
        that.onOpen(event);
      }
    };
    that.websocketClient.addEventListener("error", function (event) {
      console.log("webSocket：onerror 遇到错误", event);
      clearInterval(that.pingTimer);
      that.reconnet();
      if (that.onError) {
        that.onError(event);
      }
    });
    that.websocketClient.onclose = function (event) {
      console.log("webSocket：onclose 连接关闭");
      clearInterval(that.pingTimer);
      that.reconnet();
      if (that.onClose) {
        that.onClose(event);
      }
    };
    that.websocketClient.addEventListener("message", function (event) {
      console.log("webSocket：onmessage 收到消息", event);
      if (that.onMessage) {
        that.onMessage(event);
      }
    });
  };

  /**
   * 重连
   * @returns
   */
  this.reconnet = function () {
    var that = this;
    if (that.reconnetFlag) {
      return;
    }
    that.reconnetFlag = true;

    setTimeout(() => {
      console.log("webSocket：断线重连");
      that.connect();
      that.reconnetFlag = false;
    }, that.reconnetInterval);
  };

  /**
   * 心跳
   */
  this.ping = function () {
    var that = this;
    if (that.pingTimer) {
      clearInterval(that.pingTimer);
    }
    that.pingTimer = setInterval(() => {
      console.log("webSocket：发送心跳");
      that.websocketClient.send('{"type":"ping"}');
    }, that.pingInterval);
  };

  /**
   * 发送
   * @param {string} data
   */
  this.send = function (data) {
    return this.websocketClient.send(data);
  };
}

/**
 * 使用websocket
 * @param {string} url
 * @returns
 */
export function useWebsocketClient(url) {
  return new WebsocketClient(url);
}
