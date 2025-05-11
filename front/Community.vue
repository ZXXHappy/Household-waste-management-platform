<template>
  <div class="community-container">
    <div class="page-header">
      <h1>社区回收点</h1>
      <p>选择您所在的社区，查看附近的回收点信息</p>
    </div>
    
    <div class="community-grid">
      <div 
        v-for="item in data.communityList" 
        :key="item.id"
        class="community-card"
        @click="router.push('/front/recoverySite?communityId=' + item.id)"
      >
        <div class="card-image">
          <img :src="item.img" alt="">
        </div>
        <div class="card-content">
          <h2 class="community-name">
            <el-icon><OfficeBuilding /></el-icon>
            {{ item.name }}
          </h2>
          <div class="info-list">
            <div class="info-item">
              <el-icon><Location /></el-icon>
              <span>{{ item.address }}</span>
            </div>
            <div class="info-item">
              <el-icon><User /></el-icon>
              <span>管理员：{{ item.managerName }}</span>
            </div>
            <div class="info-item">
              <el-icon><Iphone /></el-icon>
              <span>{{ item.managerPhone }}</span>
            </div>
            <div class="info-item">
              <el-icon><MilkTea /></el-icon>
              <span>回收点数量：{{ item.recoverySiteCount }}</span>
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
import { OfficeBuilding, Location, User, Iphone, MilkTea, ArrowRight } from '@element-plus/icons-vue';

const data = reactive({
  communityList: []
})

// 因为社区的数量是有限的  所以在这里查出了所有的社区
const load = () => {
  request.get('/community/selectAll').then(res => {
    data.communityList = res.data
  })
}
load()
</script>

<style scoped>
.community-container {
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
  text-align: center;
}

.page-header h1 {
  font-size: 32px;
  color: #2c7a4d;
  margin-bottom: 12px;
  font-weight: 600;
}

.page-header p {
  color: #666;
  font-size: 16px;
}

.community-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 24px;
}

.community-card {
  background: white;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  cursor: pointer;
  border: 2px solid #e8f5ec;
}

.community-card:hover {
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

.community-card:hover .card-image img {
  transform: scale(1.05);
}

.card-content {
  padding: 24px;
}

.community-name {
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

.community-card:hover .arrow-icon {
  transform: translateX(4px);
}

@media (max-width: 768px) {
  .community-container {
    padding: 20px;
  }
  
  .page-header h1 {
    font-size: 24px;
  }
  
  .community-grid {
    grid-template-columns: 1fr;
  }
  
  .community-card {
    margin-bottom: 16px;
  }
}
</style>