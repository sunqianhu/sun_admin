/**
 * 是否是空
 * @param {*} arr
 * @returns
 */
export function isEmpty(arr) {
  return (Array.isArray(arr) && arr.length === 0) || !arr;
}
