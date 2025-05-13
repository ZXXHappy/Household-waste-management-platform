<template>
  <div class="main-content">
    <div class="notice-header">
      <h2 class="section-title">系统公告</h2>
      <div class="title-underline"></div>
      <p class="section-description">了解最新的系统更新和重要信息</p>
    </div>
    
    <div class="card notice-card">
      <el-timeline class="custom-timeline">
        <el-timeline-item
            v-for="(item, index) in data.noticeData"
            :key="index"
            :timestamp="item.time"
            :type="getTimelineItemType(index)"
            :color="getTimelineItemColor(index)"
            class="timeline-item"
        >
          <div class="notice-content">{{ item.content }}</div>
        </el-timeline-item>
      </el-timeline>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";

const data = reactive({
  noticeData: []
})

const loadNotice = () => {
  request.get('/notice/selectAll').then(res => {
    if (res.code === '200') {
      data.noticeData = res.data
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const getTimelineItemType = (index) => {
  const types = ['primary', 'success', 'warning', 'info'];
  return types[index % types.length];
}

const getTimelineItemColor = (index) => {
  const colors = ['#2196F3', '#4CAF50', '#FFD700', '#E91E63'];
  return colors[index % colors.length];
}

loadNotice()
</script>

<style scoped>
.notice-header {
  text-align: center;
  margin-bottom: 30px;
}

.section-title {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  margin-bottom: 10px;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.title-underline {
  width: 100px;
  height: 4px;
  background: linear-gradient(to right, #4CAF50, #2196F3);
  margin: 0 auto 15px;
  border-radius: 2px;
}

.section-description {
  color: #666;
  font-size: 16px;
  margin-bottom: 20px;
}

.notice-card {
  padding: 40px 30px;
  transition: all 0.3s ease;
  border: none;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
}

.custom-timeline {
  max-width: 700px;
  margin: 0 auto;
}

.timeline-item {
  margin-bottom: 25px;
  position: relative;
}

.timeline-item :deep(.el-timeline-item__timestamp) {
  font-size: 14px;
  color: #666;
  padding: 4px 10px;
  border-radius: 15px;
  background-color: rgba(33, 150, 243, 0.1);
  display: inline-block;
  margin-bottom: 6px;
  transition: all 0.3s ease;
  font-weight: 500;
}

.timeline-item:hover :deep(.el-timeline-item__timestamp) {
  background-color: rgba(33, 150, 243, 0.2);
  transform: translateY(-2px);
}

.timeline-item :deep(.el-timeline-item__node) {
  width: 16px;
  height: 16px;
  left: -1px;
  transition: all 0.3s ease;
}

.timeline-item:hover :deep(.el-timeline-item__node) {
  transform: scale(1.3);
}

.timeline-item :deep(.el-timeline-item__tail) {
  left: 7px;
  border-left: 2px solid #e4e7ed;
}

.notice-content {
  font-size: 16px;
  line-height: 1.6;
  color: #333;
  background-color: #fff;
  padding: 16px 20px;
  border-radius: 12px;
  box-shadow: 0 3px 12px rgba(0, 0, 0, 0.05);
  border-left: 4px solid;
  transition: all 0.3s ease;
}

.timeline-item:nth-child(4n+1) .notice-content {
  border-left-color: #2196F3;
}

.timeline-item:nth-child(4n+2) .notice-content {
  border-left-color: #4CAF50;
}

.timeline-item:nth-child(4n+3) .notice-content {
  border-left-color: #FFD700;
}

.timeline-item:nth-child(4n+4) .notice-content {
  border-left-color: #E91E63;
}

.timeline-item:hover .notice-content {
  transform: translateX(5px);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
}
</style>