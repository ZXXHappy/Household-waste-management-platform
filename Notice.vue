<template>
  <div style="width: 50%; margin: 10px auto">
    <div style="font-weight: bold; font-size: 24px; margin-bottom: 20px">系统公告</div>
    <div class="card" style="padding: 40px 20px">
      <el-timeline style="max-width: 600px">
        <el-timeline-item
            v-for="(item, index) in data.noticeData"
            :key="index"
            :timestamp="item.time"
        >
          {{ item.content }}
        </el-timeline-item>
      </el-timeline>
    </div>
  </div>
</template>

<script setup>

</script>

<style scoped>

</style>