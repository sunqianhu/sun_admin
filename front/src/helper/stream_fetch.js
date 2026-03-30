/**
 * 提取流
 * @param {*} method
 * @param {*} path
 * @param {*} data
 * @param {*} options
 * @returns
 */
const request = (method, path, data, options = {}) => {
  const {
    params = {},
    headers: customHeaders = {},
    onMessage,
    onComplete,
    onError,
  } = options;

  // 校验必要参数
  if (typeof onMessage !== "function") {
    throw new Error("流提取回调函数必须是一个回调函数");
  }

  // 拼接 API 前缀
  const apiPrefix = import.meta.env.VITE_API_PREFIX || "";

  // 构造带查询参数的 URL
  let fullPath = path;
  if (Object.keys(params).length > 0) {
    const searchParams = new URLSearchParams(params).toString();
    fullPath += (path.includes("?") ? "&" : "?") + searchParams;
  }

  // 构造请求头
  const token = localStorage.getItem("token");
  const headers = {
    ...(token ? { token } : {}),
    ...customHeaders,
  };
  if (method === "POST") {
    headers["Content-Type"] = "application/json";
  }

  const controller = new AbortController();
  const fetchOptions = {
    method,
    headers,
    signal: controller.signal,
  };
  if (method === "POST" && data != null) {
    fetchOptions.body = JSON.stringify(data);
  }

  fetch(apiPrefix + fullPath, fetchOptions)
    .then(async (response) => {
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      const reader = response.body.getReader();
      const decoder = new TextDecoder("utf-8");
      let buffer = "";

      try {
        while (true) {
          const { done, value } = await reader.read();
          if (value) {
            buffer += decoder.decode(value, { stream: true });
          }

          const messages = buffer.split("\n\n");

          //完成
          if (done) {
            if (buffer) {
              for (const message of messages) {
                onMessage(message);
              }
            }
            break;
          }

          //中间部分
          buffer = messages.pop();
          for (const message of messages) {
            onMessage(message);
          }
        }
        if (typeof onComplete === "function") {
          onComplete();
        }
      } finally {
        reader.releaseLock();
      }
    })
    .catch((error) => {
      if (error.name !== "AbortError" && typeof onError === "function") {
        onError(error);
      }
    });

  return {
    abort() {
      controller.abort();
    },
  };
};

const streamFetch = {};
streamFetch.get = (path, options) => {
  return request("GET", path, null, options);
};
streamFetch.post = (path, data, options) => {
  return request("POST", path, data, options);
};

export default streamFetch;
