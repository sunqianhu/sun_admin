<template>
  <el-checkbox-group v-model="keys">
    <el-checkbox
      v-for="item in dictionary"
      :label="item.value"
      :value="props.keyType === 'int' ? parseInt(item.key) : item.key"
    />
  </el-checkbox-group>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  type: {
    type: String,
    required: true,
  },
  keyType: {
    type: String,
    default: "int",
  },
});
const keys = defineModel({
  type: [Number, String, Array],
});
const dictionary = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.DictionaryCheckboxGroup/getDictionary",
    {
      params: {
        type: props.type,
      },
    }
  );
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error",
    });
    return;
  }
  dictionary.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
