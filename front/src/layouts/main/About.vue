<template>
  <el-dialog
    :model-value="true"
    title="关于系统"
    width="480"
    :draggable="true"
    append-to-body
    align-center
    @close="close"
  >
    <div v-loading="initLoading" class="about">
      <attribute-list>
        <attribute label="系统名称" :span="24">
          {{ system.system_name }}
        </attribute>
        <attribute label="系统版本" :span="24">
          {{ system.version }}
        </attribute>
      </attribute-list>
    </div>
    <template #footer>
      <el-button @click="close">关闭</el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import AttributeList from "@/components/AttributeList.vue";
import Attribute from "@/components/Attribute.vue";

const emits = defineEmits(["close"]);
const initLoading = ref(false);
const system = ref({});

/**
 * 初始化
 */
const init = async () => {
  initLoading.value = true;
  let response;
  try {
    response = await axios.get("desktop/layouts.main.About/init");
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
  system.value = response.data;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.about {
}
</style>
