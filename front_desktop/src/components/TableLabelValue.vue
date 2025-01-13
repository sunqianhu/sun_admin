<template>
  <table class="table-label-value">
    <tr v-for="(row, rowIndex) in rows" :key="rowIndex">
      <template v-for="item in row">
        <td
          valign="top"
          :width="item.labelWidth"
          :colspan="item.labelColspan"
          class="table-label-value__label"
        >
          {{ item.label }}
        </td>
        <td
          valign="top"
          :width="item.valueWidth"
          :colspan="item.valueColspan"
          class="table-label-value__value"
        >
          <vnode-render
            :vnode="item.valueVnodes"
            v-if="item.valueVnodes"
          ></vnode-render>
        </td>
      </template>
    </tr>
  </table>
</template>

<script setup>
import { ref, useSlots, watchEffect, onMounted } from "vue";
import VnodeRender from "./VnodeRender.js";

const props = defineProps({
  column: {
    type: Number,
    default: 6,
  },
});
const slots = useSlots();
let rows = ref([]); //行
let itemDefaultProps = {}; //项默认属性

/**
 * 创建项
 * @param {*} item
 */
const createItem = (vnode) => {
  let item = { ...itemDefaultProps, ...vnode.props };
  if (item["label-width"]) {
    item.labelWidth = item["label-width"];
  }
  if (item["label-colspan"]) {
    item.labelColspan = item["label-colspan"];
  }
  if (item["value-width"]) {
    item.valueWidth = item["value-width"];
  }
  if (item["value-colspan"]) {
    item.valueColspan = item["value-colspan"];
  }

  item.valueVnodes =
    vnode && vnode.children && vnode.children.default
      ? vnode.children.default()
      : [];

  return item;
};

/**
 * 获取项
 */
const getItems = () => {
  let items = [];

  const processVNodes = (vnodes) => {
    vnodes.forEach((vnode) => {
      if (vnode.type.__name === "TableLabelValueItem") {
        let item = createItem(vnode);
        items.push(item);
      } else if (vnode.children) {
        if (typeof vnode.children === "function") {
          processVNodes(vnode.children());
        } else if (Array.isArray(vnode.children)) {
          processVNodes(vnode.children);
        }
      }
    });
  };

  if (!slots || !slots.default) {
    return items;
  }

  let vnodes = slots.default();
  if (vnodes.length > 0) {
    processVNodes(vnodes);
  }
  return items;
};

/**
 * 设置行
 * @param items
 */
const setRows = (items) => {
  let row = [];
  let columnNumber = 0; //列数量

  rows.value = [];
  items.forEach((item, index) => {
    let labelColspan = item.labelColspan ? item.labelColspan : 1;
    let valueColspan = item.valueColspan ? item.valueColspan : 1;
    columnNumber += parseInt(labelColspan) + parseInt(valueColspan);

    row.push(item);
    if (props.column - columnNumber < 2 || index == items.length - 1) {
      rows.value.push(row);
      columnNumber = 0;
      row = [];
    }
  });
};

/**
 * 初始化
 */
const init = () => {
  let items = getItems();
  setRows(items);
};

/**
 * 监听
 */
watchEffect(() => {
  init();
});

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.table-label-value {
  width: 100%;
  border-collapse: collapse;
  .table-label-value__label {
    border: 1px solid var(--border-color-base);
    padding: var(--padding-xs) var(--padding-sm);
    background-color: var(--background-color-base);
  }
  .table-label-value__value {
    border: 1px solid var(--border-color-base);
    padding: var(--padding-xs) var(--padding-sm);
  }
}
</style>
