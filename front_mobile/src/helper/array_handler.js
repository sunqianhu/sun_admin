import { useRouter } from "vue-router";

/**
 * 是否为空
 * @param {*} arr
 * @returns
 */
export const isEmpty = (arr) => {
  return (Array.isArray(arr) && arr.length === 0) || !arr;
};
