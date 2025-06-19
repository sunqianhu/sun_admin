<template>
  <div style="margin: 50px">
    <el-form :model="form" label-width="auto">
      <el-form-item label="选择用户">
        <select-user v-model="form.user_id"></select-user>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref } from "vue";
const form = ref({
  user_id: 0,
});
</script>

<style scoped></style>
