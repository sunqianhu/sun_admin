<template>
  <div style="margin: 50px">
    <table-label-value :column="6">
      <table-label-value-item
        label="字段1"
        :label-colspan="2"
        label-width="100"
        :content-colspan="2"
        content-width="100"
      >
        内容1
      </table-label-value-item>
      <table-label-value-item label="字段2">
        <a href="#">内容2</a>
      </table-label-value-item>
      <table-label-value-item label="字段3">内容3</table-label-value-item>
      <table-label-value-item label="字段4" :content-colspan="1"
        >内容4</table-label-value-item
      >
      <table-label-value-item label="字段5">内容5</table-label-value-item>
      <table-label-value-item label="字段6">内容6</table-label-value-item>
      <table-label-value-item label="字段7">内容7</table-label-value-item>
      <table-label-value-item label="字段8">内容8</table-label-value-item>
      <table-label-value-item label="字段9">内容9</table-label-value-item>
    </table-label-value>
  </div>
</template>

<script setup>
import { ref } from "vue";
import TableLabelValue from "../components/TableLabelValue.vue";
import TableLabelValueItem from "../components/TableLabelValueItem.vue";
</script>

<style scoped></style>
