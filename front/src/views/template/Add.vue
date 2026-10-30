<template>
  <el-dialog
    :model-value="true"
    title="添加字典"
    width="500"
    align-center
    :draggable="true"
    class="add"
    @close="close"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form
        :model="dictionary"
        :rules="rules"
        scroll-to-error
        ref="dictionaryRef"
        label-width="120px"
      >
        <el-form-item label="字典类型" prop="type">
          <el-input v-model="dictionary.type" />
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

const emits = defineEmits(["close", "submited"]);
const dictionary = ref({});
const dictionaryRef = ref({});
const rules = {
  type: [{ required: true, message: "请输入字典类型", trigger: "blur" }],
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
  await dictionaryRef.value.validate();
  submitLoading.value = true;
  let response;
  try {
    response = await axios.post(
      "desktop/system.dictionary.Add/save",
      dictionary.value,
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
</script>
<style lang="scss" scoped>
.add {
  .scrollbar {
    padding-right: 50px;
  }
}
</style>
