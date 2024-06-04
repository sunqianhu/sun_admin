<template>
  <table class="table-label-value">
    <tr v-for="(row, rowIndex) in rows" :key="rowIndex">
      <template v-for="item in row">
        <td :width="item.labelWidth" :colspan="item.labelColspan" class="label">
          {{ item.label }}
        </td>
        <td :width="item.contentWidth" :colspan="item.contentColspan" class="content">
          <vnode-render :vnode="item.contentVnodes" v-if="item.contentVnodes"></vnode-render>
        </td>
      </template>
    </tr>
  </table>
</template>

<script setup>
import { ref, useSlots, watch, onMounted } from "vue";
import VnodeRender from "./VnodeRender.js";

const props = defineProps({
  column: {
    type: Number,
    default: 6
  }
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
  if (item["content-width"]) {
    item.contentWidth = item["content-width"];
  }
  if (item["content-colspan"]) {
    item.contentColspan = item["content-colspan"];
  }
  item.contentVnodes =
    vnode && vnode.children && vnode.children.default ? vnode.children.default() : [];
  return item;
};

/**
 * 获取项
 */
const getItems = () => {
  let items = [];
  if (!slots || !slots.default) {
    return items;
  }

  let vnodes = slots.default();
  if (vnodes.length === 0) {
    return items;
  }

  vnodes = vnodes.filter((vnode) => {
    if (vnode.type.__name == "TableLabelValueItem") {
      return true;
    }
    return false;
  });
  if (vnodes.length === 0) {
    return items;
  }

  vnodes.forEach((vnode) => {
    let item = createItem(vnode);
    items.push(item);
  });

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
    let contentColspan = item.contentColspan ? item.contentColspan : 1;
    columnNumber += labelColspan + contentColspan;

    row.push(item);
    if (props.column - columnNumber < 2 || index >= items.length - 1) {
      rows.value.push(row);
      columnNumber = 0;
      row = [];
    }
  });
  console.log(`output->rows`, rows);
};

/**
 * 初始化
 */
const init = () => {
  let items = getItems();
  setRows(items);
};

//监听插槽内容改变
watch(
  () => {
    const allVnodes = [];
    const vnodes = slots.default ? slots.default() : [];
    vnodes.forEach((vnode) => {
      if (vnode.children && vnode.children.default) {
        allVnodes.push(...vnode.children.default());
      }
    });
    return allVnodes;
  },
  () => {
    init();
  }
);

onMounted(() => {
  init();
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
