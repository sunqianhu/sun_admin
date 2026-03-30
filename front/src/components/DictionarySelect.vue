<template>
  <el-select
    v-model="keys"
    filterable
    clearable
    :multiple="multiple"
    collapse-tags
    collapse-tags-tooltip
    :max-collapse-tags="maxCollapseTags"
    :empty-values="['', undefined]"
  >
    <el-option
      v-for="item in dictionary"
      :label="item.value"
      :value="props.keyType === 'int' ? parseInt(item.key) : item.key"
    />
  </el-select>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

const props = defineProps({
  type: {
    type: String,
    required: true,
  },
  multiple: {
    type: Boolean,
    default: false,
  },
  keyType: {
    type: String,
    default: "int",
  },
  maxCollapseTags: {
    type: Number,
    default: 1,
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
    "desktop/components.DictionarySelect/getDictionary",
    {
      params: {
        type: props.type,
      },
    },
  );
  if (response.code != 0) {
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
