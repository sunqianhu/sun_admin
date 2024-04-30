/**
 * 数组处理器
 */
class ArrayHandler {
  /**
   * 是否为空
   * @param {*} arr
   * @returns
   */
  isEmpty(arr) {
    return (Array.isArray(arr) && arr.length === 0) || !arr;
  }
}

export default ArrayHandler;
