<template>
  <el-dialog
    :model-value="true"
    title="修改部门"
    width="500"
    :draggable="true"
    class="edit"
    @close="close"
  >
    <el-scrollbar max-height="300px" v-loading="initLoading" class="scrollbar">
      <el-form
        :model="department"
        :rules="rules"
        scroll-to-error
        ref="departmentRef"
        label-width="120px"
      >
        <el-form-item label="所属部门">
          <tree-department-select
            v-model="department.department_id"
          ></tree-department-select>
        </el-form-item>
        <el-form-item
          label="部门类型"
          prop="type"
          :empty-values="[0, '', undefined]"
        >
          <type-select v-model="department.type"></type-select>
        </el-form-item>
        <el-form-item label="部门名称" prop="name">
          <el-input v-model="department.name" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input type="number" v-model="department.sort" />
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
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";
import TypeSelect from "@/components/department/TypeSelect.vue";

const props = defineProps(["id"]);
const emits = defineEmits(["close", "submited"]);
const department = ref({});
const departmentRef = ref();
const rules = {
  type: [{ required: true, message: "请输入部门类型", trigger: "blur" }],
  name: [{ required: true, message: "请输入部门名称", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }],
};
const initLoading = ref(false);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/system.department.Edit/init", {
      params: { id: props.id },
    });
  } finally {
    initLoading.value = false;
  }
  if (response.code != 0) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }

  department.value = response.data;
};

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
  await departmentRef.value.validate();
  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.department.Edit/save",
      department.value,
    );
  } finally {
    submitLoading.value = false;
  }
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
  emits("submited", true);
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.edit {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
}
</style>
