/**
 * 使用缓存
 * @param {*} key
 * @param {*} ttl
 * @returns
 */
export const useCache = (key, ttl) => {
  const setKey = (key) => {
    this.key = key;
  };

  const setTtl = (ttl) => {
    this.ttl = ttl;
  };

  /**
   * 设置
   * @param {*} data
   */
  const setCache = (data) => {
    const record = {
      data,
      expire: Date.now() + ttl,
    };
    try {
      localStorage.setItem(key, JSON.stringify(record));
    } catch (error) {
      console.warn(`缓存写入失败: ${key}`, error);
    }
  };

  /**
   * 获取
   * @returns
   */
  const getCache = () => {
    const cached = localStorage.getItem(key);
    if (!cached) {
      return null;
    }

    let record;
    try {
      record = JSON.parse(cached);
    } catch (error) {
      console.warn(`缓存解析失败: ${key}`, error);
      clear();
      return null;
    }

    if (Date.now() > record.expire) {
      clear();
      return null;
    }

    return record.data;
  };

  /**
   * 清除
   */
  const clearCache = () => {
    localStorage.removeItem(key);
  };

  return {
    set,
    get,
    clear,
  };
};
