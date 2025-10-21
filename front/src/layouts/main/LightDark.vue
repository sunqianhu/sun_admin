<template>
  <div class="light-dark">
    <el-tooltip effect="dark" content="切换主题" placement="bottom">
      <el-switch
        v-model="isDark"
        :active-action-icon="Moon"
        :inactive-action-icon="Sunny"
        @change="useToggle"
      />
    </el-tooltip>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useDark, useToggle } from "@vueuse/core";
import { Sunny, Moon } from "@element-plus/icons-vue";

const isDark = useDark();
</script>

<style lang="scss" scoped>
.light-dark {
  cursor: pointer;
  :deep(.el-switch) {
    height: inherit;
    .el-icon {
      color: #203549;
    }
  }
  :deep(.el-switch.is-checked) {
    .el-switch__core {
      background-color: #696969;
      border-color: #203549;
    }
    .el-icon {
      color: #506579;
    }
  }
}
</style>
