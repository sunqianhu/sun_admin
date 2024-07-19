<template>
  <div style="margin: 50px">
    <panel-card title="标题标题">内容</panel-card>
    <panel-inline title="标题标题" style="margin-top: 16px">内容</panel-inline>
  </div>
</template>

<script setup>
import { ref } from "vue";
import TableLabelValue from "../components/TableLabelValue.vue";
import TableLabelValueItem from "../components/TableLabelValueItem.vue";

console.log(`output->import.meta.env.VITE_API_URL`, import.meta.env.VITE_API_URL);
</script>

<style scoped></style>
