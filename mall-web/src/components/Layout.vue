<template>
  <el-container>
    <Header />
    <el-container>
      <el-main>
        <slot></slot>
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup>
import Header from '@/components/Header.vue';
</script>

<style scoped lang="scss">
.el-container {
  margin-top: 0px; // 确保内容在 header 下方
}
</style>