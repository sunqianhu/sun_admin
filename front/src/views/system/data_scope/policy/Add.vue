<template>
  <el-dialog
    :model-value="true"
    title="添加策略"
    width="500"
    :draggable="true"
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form
        :model="policy"
        :rules="rules"
        scroll-to-error
        ref="policyRef"
        label-width="100px"
      >
        <el-form-item label="名称" prop="name">
          <el-input v-model="policy.name" />
        </el-form-item>
        <el-form-item label="类型" prop="type">
          <dictionary-select
            v-model="policy.type"
            type="data_scope_policy_type"
          ></dictionary-select>
        </el-form-item>
        <el-form-item
          label="指定单位"
          prop="department_ids"
          :required="true"
          v-if="policy.type == 98"
        >
          <tree-department-select v-model="policy.department_ids">
          </tree-department-select>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="policy.sort" type="number" />
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" :loading="submitLoading" @click="submitForm">
        提交
      </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/helper/axios";
import TreeDepartmentSelect from "./TreeDepartmentSelect.vue";

const props = defineProps(["dataScopeId"]);
console.log(props.dataScopeId);
const emits = defineEmits(["close", "submited"]);
const policy = ref({
  data_scope_id: props.dataScopeId,
  department_ids: [],
  sort: 0,
});
const policyRef = ref({});
const rules = {
  name: [{ required: true, message: "请输入名称", trigger: "blur" }],
  data_scope: [
    { required: true, message: "请选择数据范围", trigger: "change" },
  ],
  department_ids: [
    {
      validator: (rule, value, callback) => {
        if (policy.value.data_scope === 99) {
          if (!value || value.length === 0) {
            callback(new Error("请选择指定单位"));
            return;
          }
        }
        callback();
      },
      trigger: "change",
    },
  ],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }],
};
const submitLoading = ref(false);

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await policyRef.value.validate();
  submitLoading.value = true;
  const response = await axios.post(
    "desktop/system.data_scope.policy.Add/save",
    policy.value,
  );
  submitLoading.value = false;
  if (response.code != 1) {
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
  emits("submited", true);
};
</script>
<style lang="scss" scoped>
.add {
  .scrollbar {
    padding-right: 50px;
  }
}
</style>
