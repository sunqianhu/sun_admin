<template>
  <div class="icon-picker">
    <el-icon
      size="18"
      class="icon-picker__selected-icon"
      v-if="selectedIconName !== ''"
    >
      <component :is="icons[selectedIconName]" />
    </el-icon>
    <el-popover
      title="选择图标"
      :visible="visible"
      placement="top"
      :width="500"
    >
      <template #reference>
        <el-button @click="open" class="popover__reference"> 选择 </el-button>
      </template>
      <div class="popover__content">
        <div class="search">
          <el-input placeholder="搜索图标" v-model="searchKeyword" clearable />
        </div>
        <el-scrollbar height="400px">
          <div class="icon-grid">
            <div
              v-for="(iconName, index) in filteredIconNames"
              :key="index"
              :title="iconName"
              class="icon"
              @click="select(iconName)"
            >
              <el-icon size="18">
                <component :is="icons[iconName]" />
              </el-icon>
            </div>
          </div>
        </el-scrollbar>
      </div>
    </el-popover>
  </div>
</template>

<script setup>
import { ref, watch, computed, onBeforeUnmount, onMounted } from "vue";
import * as icons from "@element-plus/icons-vue";

const props = defineProps({
  modelValue: {
    type: String,
    default: "",
  },
});
const emits = defineEmits(["update:modelValue"]);
const iconNames = Object.keys(icons);
const selectedIconName = ref(props.modelValue);
const visible = ref(false);
const searchKeyword = ref("");
const filteredIconNames = computed(() => {
  const keyword = searchKeyword.value.trim().toLowerCase();
  if (keyword === "") {
    return iconNames;
  }
  return iconNames.filter((iconName) => {
    return iconName.toLowerCase().includes(keyword);
  });
});

/**
 * 打开
 */
const open = () => {
  visible.value = true;
};

/**
 * 选择
 * @param icon
 */
const select = async (iconName) => {
  selectedIconName.value = iconName;
  visible.value = false;
};

/**
 * 页面点击关闭
 * @param e
 */
const closeByDocumentClick = (e) => {
  const referenceEl = document.querySelector(".popover__reference");
  const contentEl = document.querySelector(".popover__content");

  if (
    visible.value &&
    !referenceEl.contains(e.target) &&
    !contentEl.contains(e.target)
  ) {
    visible.value = false;
  }
};

watch(
  () => props.modelValue,
  async (newValue) => {
    selectedIconName.value = newValue;
  },
  {
    deep: true,
  }
);
watch(
  () => selectedIconName.value,
  (newValue) => {
    emits("update:modelValue", newValue);
  },
  {
    deep: true,
  }
);

/**
 * 关闭图标选择器
 */
onMounted(() => {
  document.addEventListener("click", closeByDocumentClick);
});
/**
 * 销毁监听
 */
onBeforeUnmount(() => {
  document.removeEventListener("click", closeByDocumentClick);
});
</script>

<style lang="scss" scoped>
.icon-picker {
  display: flex;
  align-items: center;
  .icon-picker__selected-icon {
    margin-right: var(--margin-sm);
  }
  .icon-picker__popover {
  }
}

.popover__content {
  .search {
  }
  .icon-grid {
    margin-top: var(--margin-sm);
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(40px, 1fr));
    gap: 10px;
    .icon {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 40px;
      border-radius: 4px;
      transition: all 0.2s ease;
      cursor: pointer;
      &:hover {
        background-color: #f5f7fa;
        transform: scale(1.2);
        color: #409eff;
      }
    }
  }
}
</style>
