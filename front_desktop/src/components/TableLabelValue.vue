<template>
  <table class="table-label-value">
    <tr v-for="(row, rowIndex) in rows" :key="rowIndex">
      <template v-for="item in row">
        <td :width="item.labelWidth" :colspan="item.labelColspan" class="label">
          {{ item.label }}
        </td>
        <td
          :width="item.contentWidth"
          :colspan="item.contentColspan"
          class="content"
        >
          <vnode-render
            :vnode="item.contentVnodes"
            v-if="item.contentVnodes"
          ></vnode-render>
        </td>
      </template>
    </tr>
  </table>
</template>

<script setup>
import { useSlots } from "vue";
import VnodeRender from "./VnodeRender.js";

const props = defineProps({
  column: {
    type: Number,
    default: 6
  }
});
const slots = useSlots();
let items = [];
let vnodes = [];
let defaultProps = {};
let rows = [];
let row = [];
let columnNumber = 0; //列数量

/**
 * 创建项
 * @param {*} item
 */
const createItem = (vnode) => {
  let item = {};
  item = { ...defaultProps, ...vnode.props };
  if (item["label-width"]) {
    item.labelWidth = item["label-width"];
  }
  if (item["label-colspan"]) {
    item.labelColspan = item["label-colspan"];
  }
  if (item["content-width"]) {
    item.contentWidth = item["content-width"];
  }
  if (item["content-colspan"]) {
    item.contentColspan = item["content-colspan"];
  }
  item.contentVnodes =
    vnode && vnode.children && vnode.children.default
      ? vnode.children.default()
      : [];
  return item;
};

//项
if (slots && slots.default) {
  vnodes = slots.default();
  vnodes.filter((vnode) => {
    if (vnode.type.__name == "TableLabelValueItem") {
      return true;
    }
    return false;
  });
  vnodes.forEach((vnode) => {
    let item = createItem(vnode);
    items.push(item);
  });
}

//行
items.forEach((item, index) => {
  let labelColspan = item.labelColspan ? item.labelColspan : 1;
  let contentColspan = item.contentColspan ? item.contentColspan : 1;
  columnNumber += labelColspan + contentColspan;
  row.push(item);

  if (props.column - columnNumber < 2 || index === items.length - 1) {
    columnNumber = 0;
    rows.push(row);
    row = [];
  }
});
</script>

<style lang="scss" scoped>
.table-label-value {
  width: 100%;
  border-collapse: collapse;
  td {
    border: 1px solid var(--border-color-base);
    padding: var(--padding-xs) var(--padding-sm);
  }
  .label {
    background-color: var(--background-color-base);
  }
}
</style>
