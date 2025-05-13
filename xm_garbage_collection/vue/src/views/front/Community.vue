<template>
  <div class="main-content">
    <div class="community-header">
      <h2 class="section-title">社区垃圾投放/回收点</h2>
      <div class="title-underline"></div>
      <p class="section-description">选择您所在的社区，查看垃圾投放和回收点信息</p>
    </div>
    
    <div class="community-list">
      <el-row :gutter="30">
        <el-col :xs="24" :sm="12" :md="8" v-for="item in data.communityList" :key="item.id" class="community-item">
          <div @click="router.push('/front/recoverySite?communityId=' + item.id)" class="card community-card">
            <div class="community-img-wrapper">
              <div class="community-img-container">
                <img :src="item.img" alt="" class="community-image">
              </div>
              <div class="community-name">
                <el-icon class="info-icon"><OfficeBuilding /></el-icon>
                <span>{{ item.name }}</span>
              </div>
            </div>
            <div class="community-info">
              <div class="info-row"><el-icon class="info-icon"><Location/></el-icon>{{ item.address }}</div>
              <div class="info-row"><el-icon class="info-icon"><User /></el-icon>{{ item.managerName }}</div>
              <div class="info-row"><el-icon class="info-icon"><Iphone /></el-icon>{{ item.managerPhone }}</div>
              <div class="sites-count">
                <el-icon class="info-icon"><MilkTea /></el-icon>
                回收点：<span class="count-badge">{{ item.recoverySiteCount }}</span>
              </div>
              <el-button type="success" class="view-btn">查看详情</el-button>
        </div>
      </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import { OfficeBuilding, Location, User, Iphone, MilkTea } from '@element-plus/icons-vue';

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
.community-header {
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

.community-list {
  margin-bottom: 30px;
}

.community-item {
  margin-bottom: 30px;
}

.community-card {
  height: 100%;
  display: flex;
  flex-direction: column;
  padding: 0;
  overflow: hidden;
  transition: all 0.3s ease;
  border: none;
  border-radius: 15px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
  cursor: pointer;
  background: #fff;
}

.community-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 15px 30px rgba(76, 175, 80, 0.15);
}

.community-img-wrapper {
  position: relative;
}

.community-img-container {
  height: 180px;
  overflow: hidden;
}

.community-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: all 0.5s ease;
}

.community-card:hover .community-image {
  transform: scale(1.1);
}

.community-name {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 15px;
  background: linear-gradient(to top, rgba(0,0,0,0.7), rgba(0,0,0,0));
  color: white;
  font-size: 20px;
  font-weight: 600;
  display: flex;
  align-items: center;
}

.community-name .info-icon {
  color: #FFE082;
  margin-right: 8px;
}

.community-info {
  flex: 1;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.info-row {
  display: flex;
  align-items: center;
  color: #666;
  font-size: 14px;
}

.info-icon {
  margin-right: 8px;
  color: #2196F3;
}

.sites-count {
  display: flex;
  align-items: center;
  margin-top: 10px;
  padding: 5px 12px;
  background-color: rgba(33, 150, 243, 0.05);
  border-radius: 20px;
  width: fit-content;
}

.count-badge {
  display: inline-block;
  padding: 2px 10px;
  background: #FFE082;
  color: #333;
  font-weight: 600;
  border-radius: 12px;
  margin-left: 5px;
}

.view-btn {
  margin-top: auto;
  align-self: center;
  padding: 8px 20px;
  border-radius: 20px;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  border: none;
  transition: all 0.3s ease;
  font-weight: 500;
  width: 100%;
  margin-top: 15px;
}

.view-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
  background: linear-gradient(135deg, #388E3C, #1976D2);
}
</style>