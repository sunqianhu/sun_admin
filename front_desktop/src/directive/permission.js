import { hasPermission } from "../helper/permission";

export default {
  //挂载完成后
  mounted(el, binding, vnode, prevVnode) {
    let key = binding.value;
    if (hasPermission(key)) {
      return;
    }

    if (el.parentNode) {
      el.parentNode.removeChild(el);
    } else {
      el.style.display = "none";
    }
  }
};
