<template>
  <div class="recovery-container">
    <div class="page-header">
      <div class="header-content">
        <h1>{{ data.community.name }}</h1>
        <p>垃圾投放/回收点</p>
      </div>
      <div class="header-stats">
        <div class="stat-item">
          <el-icon><Place /></el-icon>
          <span>回收点总数：{{ data.tableData.length }}</span>
        </div>
        <div class="stat-item">
          <el-icon><Open /></el-icon>
          <span>运行中：{{ data.tableData.filter(item => item.status === '运行中').length }}</span>
        </div>
      </div>
    </div>

    <div class="recovery-grid">
      <div 
        v-for="item in data.tableData" 
        :key="item.id"
        class="recovery-card"
        @click="router.push('/front/recoverySiteDetail?id=' + item.id)"
      >
        <div class="card-image">
          <img :src="item.img" alt="">
          <div class="status-tag" :class="item.status === '运行中' ? 'status-open' : 'status-closed'">
            {{ item.status }}
          </div>
        </div>
        <div class="card-content">
          <h2 class="site-name">
            <el-icon><Place /></el-icon>
            {{ item.name }}
          </h2>
          <div class="info-list">
            <div class="info-item">
              <el-icon><User /></el-icon>
              <span>{{ item.managerName }}</span>
            </div>
            <div class="info-item">
              <el-icon><Iphone /></el-icon>
              <span>{{ item.managerPhone }}</span>
            </div>
            <div class="info-item">
              <el-icon><Clock /></el-icon>
              <span>{{ item.timeRange }}</span>
            </div>
          </div>
          <div class="card-footer">
            <span class="view-more">查看详情</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";
import { Place, User, Iphone, Clock, Open, ArrowRight } from '@element-plus/icons-vue';

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  communityId: router.currentRoute.value.query.communityId,
  tableData: [],
  community: {}
})

request.get('/community/selectById/' + data.communityId).then(res => {
  data.community = res.data
})

const load = () => {
  request.get('/recoverySite/selectAll', {
    params: {
      communityId: data.communityId
    }
  }).then(res => {
    if (res.code === '200') {
      data.tableData = res.data || []
    } else {
      ElMessage.error(res.msg)
    }
  })
}
load()
</script>

<style scoped>
.recovery-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px 15px;
}

.page-header {
  margin-bottom: 25px;
  background: white;
  border-radius: 15px;
  padding: 20px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
}

.header-content {
  text-align: center;
  margin-bottom: 20px;
}

.header-content h1 {
  font-size: 32px;
  color: #2c7a4d;
  margin-bottom: 8px;
  font-weight: 600;
}

.header-content p {
  color: #666;
  font-size: 16px;
}

.header-stats {
  display: flex;
  justify-content: center;
  gap: 40px;
  margin-top: 20px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #4a5568;
  font-size: 16px;
  font-weight: 500;
}

.stat-item .el-icon {
  color: #65b57a;
  font-size: 20px;
}

.recovery-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 24px;
  justify-content: center;
}

.recovery-card {
  background: white;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  cursor: pointer;
  border: 2px solid #e8f5ec;
  width: 350px;
  flex-grow: 0;
}

.recovery-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(101, 181, 122, 0.12);
  border-color: #7bc88c;
}

.card-image {
  position: relative;
  padding-top: 56.25%;
  overflow: hidden;
}

.card-image img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.recovery-card:hover .card-image img {
  transform: scale(1.05);
}

.status-tag {
  position: absolute;
  top: 16px;
  right: 16px;
  padding: 6px 16px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
  color: white;
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(4px);
}

.status-open {
  background: rgba(101, 181, 122, 0.9);
}

.status-closed {
  background: rgba(245, 108, 108, 0.9);
}

.card-content {
  padding: 24px;
}

.site-name {
  font-size: 20px;
  color: #2c7a4d;
  margin: 0 0 16px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.info-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #4a5568;
  font-size: 15px;
}

:deep(.el-icon) {
  color: #65b57a;
  font-size: 18px;
}

.card-footer {
  margin-top: 20px;
  padding-top: 16px;
  border-top: 1px solid #e8f5ec;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.view-more {
  color: #65b57a;
  font-weight: 500;
  font-size: 15px;
}

.arrow-icon {
  transition: transform 0.3s ease;
}

.recovery-card:hover .arrow-icon {
  transform: translateX(4px);
}

@media (max-width: 768px) {
  .recovery-container {
    padding: 20px;
  }
  
  .page-header {
    padding: 20px;
  }
  
  .header-content h1 {
    font-size: 24px;
  }
  
  .header-stats {
    flex-direction: column;
    gap: 16px;
    align-items: center;
  }
  
  .recovery-grid {
    grid-template-columns: 1fr;
  }
  
  .recovery-card {
    margin-bottom: 16px;
  }
}
</style>