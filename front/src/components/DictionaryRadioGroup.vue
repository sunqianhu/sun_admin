<template>
  <el-radio-group v-model="key">
    <el-radio
      v-for="item in dictionary"
      :label="item.value"
      :value="props.keyType === 'int' ? parseInt(item.key) : item.key"
    />
  </el-radio-group>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
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
const key = defineModel({
  type: [Number, String],
});
const dictionary = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get(
    "desktop/components.DictionaryRadioGroup/getDictionary",
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
