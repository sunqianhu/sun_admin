const key = "watermark";
const ttl = 60 * 60 * 12 * 1000;

/**
 * 设置
 * @param {*} data
 */
const set = (data) => {
  const record = {
    data: data,
    expire: Date.now() + ttl,
  };
  localStorage.setItem(key, JSON.stringify(record));
};

/**
 * 得到
 * @returns
 */
const get = () => {
  const cached = localStorage.getItem(key);
  if (!cached) {
    return null;
  }

  const record = JSON.parse(cached);
  if (Date.now() > record.expire) {
    clear();
    return null;
  }

  return record.data;
};

/**
 * 清除
 * @param {*} data
 */
const clear = () => {
  localStorage.removeItem(key);
};

export default {
  set,
  get,
  clear,
};
