<template>
  <el-radio-group v-model="key" @change="change">
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
const emits = defineEmits(["change"]);
const dictionary = ref([]);
const key = defineModel({
  type: [Number, String],
});

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

/**
 * 改变
 * @param value
 */
const change = (value) => {
  emits("change", value);
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
