<template>
  <el-dialog
    :model-value="true"
    title="修改数据权限"
    width="600"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="300px" v-loading="initLoading" class="scrollbar">
      <el-form
        :model="editDataScope"
        :rules="rules"
        scroll-to-error
        :validate-on-rule-change="false"
        ref="editDataScopeRef"
        label-position="top"
      >
        <el-form-item
          v-for="(dataScope, index) in editDataScope.data_scopes"
          :label="dataScope.name"
          :prop="`data_scopes.${index}.policy_id`"
        >
          <el-radio-group
            v-model="editDataScope.data_scopes[index].policy_id"
            class="radio-group"
          >
            <div v-for="policiy in dataScope.policies" class="radio-item">
              <el-radio :value="policiy.id">
                {{ policiy.name }}
              </el-radio>
            </div>
          </el-radio-group>
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

const props = defineProps(["roleId"]);
const emits = defineEmits(["close", "submited"]);
const editDataScope = ref({
  role_id: props.roleId,
  data_scopes: [],
});
const editDataScopeRef = ref();
const rules = ref({});
const initLoading = ref(false);
const submitLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  const response = await axios.get("desktop/system.role.EditDataScope/init", {
    params: {
      role_id: props.roleId,
    },
  });
  initLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  editDataScope.value.data_scopes = response.data.data_scopes;
  await nextTick();
  setRule();
};

/**
 * 设置表单验证规则
 */
const setRule = () => {
  const newRules = {};
  editDataScope.value.data_scopes.forEach((dataScope, index) => {
    newRules[`data_scopes.${index}.policy_id`] = [
      {
        validator: (rule, value, callback) => {
          if (value === 0 || value == null || value === "") {
            callback(new Error(`请选择${dataScope.name}`));
          } else {
            callback();
          }
        },
        trigger: "change",
      },
    ];
  });
  rules.value = newRules;
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
  await editDataScopeRef.value.validate();
  submitLoading.value = true;
  const response = await axios.post(
    "desktop/system.role.EditDataScope/save",
    editDataScope.value
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

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.edit {
  .scrollbar {
    padding-right: 50px;
    .radio-group {
      width: 100%;
      display: block;
      .radio-item {
        flex: 1;
      }
    }
  }
}
</style>
