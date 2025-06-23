<template>
  <div style="margin: 50px; font-size: var(--font-size)">
    <users-selector v-model="userId"></users-selector>
  </div>
</template>

<script setup>
import { ref } from "vue";

const userId = ref([1, 2]);
</script>

<style scoped></style>
