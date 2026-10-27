<template>
  <el-dialog
    :model-value="true"
    title="策略列表"
    width="600"
    :draggable="true"
    @close="close"
    class="index"
  >
    <div class="tool-bar">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>

    <div class="list">
      <el-table
        :data="policies"
        v-loading="listLoading"
        row-key="id"
        class="table"
      >
        <el-table-column prop="name" label="名称" />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column
          v-slot="{ row }"
          label="操作"
          fixed="right"
          width="140"
        >
          <el-button size="small" @click="openEdit(row.id)">修改</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="del(row.id)">
            <template #reference>
              <el-button size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </el-table-column>
      </el-table>
    </div>

    <add
      :data-scope-id="props.dataScopeId"
      @close="addFlag = false"
      @submited="
        getPolicies();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <edit
      :id="rowId"
      @close="editFlag = false"
      @submited="
        getPolicies();
        editFlag = false;
      "
      v-if="editFlag"
    ></edit>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Plus } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import Add from "./Add.vue";
import Edit from "./Edit.vue";

const props = defineProps({
  dataScopeId: {
    type: Number,
    default: 0,
  },
});
const emits = defineEmits(["close"]);
const query = ref({
  data_scope_id: props.dataScopeId,
});
const rowId = ref(0);
const policies = ref([]);
const listLoading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 得到策略列表
 */
const getPolicies = async () => {
  listLoading.value = true;
  let response;
  try {
    response = await axios.get(
      "desktop/system.data_scope.policy.Index/getPolicies",
      {
        params: query.value,
      },
    );
  } finally {
    listLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  policies.value = response.data;
};

/**
 * 打开添加页面
 */
const openAdd = () => {
  addFlag.value = true;
};

/**
 * 打开修改
 */
const openEdit = (id) => {
  editFlag.value = true;
  rowId.value = id;
};

/**
 * 删除
 * @param {number} id
 */
const del = async (id) => {
  const response = await axios.post(
    "desktop/system.data_scope.policy.Index/delete",
    {
      id: id,
    },
  );
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  ElMessage({
    message: response.message,
    type: "success",
  });
  getPolicies();
};

onMounted(() => {
  getPolicies();
});
</script>

<style lang="scss" scoped>
.index {
  .list {
    margin-top: var(--margin);
    :deep(th.el-table__cell) {
      background-color: var(--background-color-lighter);
    }
    .table {
      width: 100%;
    }
  }
}
</style>
