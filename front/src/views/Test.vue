<template>
  <div style="margin: 50px; font-size: var(--font-size)">
    <user-select v-model="userId"></user-select>
  </div>
</template>

<script setup>
import { ref } from "vue";

const userId = ref(0);
</script>

<style scoped></style>
