<template>
  <div style="margin: 50px">
    <el-form :model="form" label-width="auto">
      <el-form-item label="选择用户">
        <select-users v-model="form.user_id"></select-users>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref } from "vue";
const form = ref({
  user_id: [],
});
</script>

<style scoped></style>
