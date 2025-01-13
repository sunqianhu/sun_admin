import { defineComponent } from "vue";

export default defineComponent({
  name: "VnodeRender",
  props: {
    vnode: {
      type: Object,
      require: true,
    },
  },
  render() {
    return this.vnode;
  },
});
