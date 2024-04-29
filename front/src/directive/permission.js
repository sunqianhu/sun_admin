import Permission from "../helper/Permission";

const permission = new Permission();

export default {
  //挂载完成后
  mounted(el, binding, vnode, prevVnode) {
    let name = binding.value;
    if (permission.hasPermission(name)) {
      return;
    }

    if (el.parentNode) {
      el.parentNode.removeChild(el);
    } else {
      el.style.display = "none";
    }
  }
};
