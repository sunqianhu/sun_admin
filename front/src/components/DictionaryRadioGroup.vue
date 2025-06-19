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
  modelValue: {
    type: [Number, String],
    default: "",
  },
  type: {
    type: String,
    required: true,
  },
  keyType: {
    type: String,
    default: "int",
  },
});
const emits = defineEmits(["update:modelValue"]);
const dictionary = ref([]);
const key = ref(props.modelValue);

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

watch(
  () => props.modelValue,
  (newValue) => {
    key.value = newValue;
  },
  {
    deep: true,
  }
);
watch(
  () => key.value,
  (newValue) => {
    emits("update:modelValue", newValue);
  },
  {
    deep: true,
  }
);

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped></style>
