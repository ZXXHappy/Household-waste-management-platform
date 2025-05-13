<template>
  <div class="main-content">
    <div class="recovery-site-header">
      <h2 class="section-title">{{ data.community.name }} 垃圾投放/回收点</h2>
      <div class="title-underline"></div>
      <p class="section-description">选择合适的回收点进行垃圾投放或回收申请</p>
    </div>
    
    <div class="recovery-sites-container">
      <el-row :gutter="30">
        <el-col :xs="24" :sm="12" :md="8" v-for="item in data.tableData" :key="item.id">
          <div @click="router.push('/front/recoverySiteDetail?id=' + item.id)" class="card site-card">
            <div class="site-img-container">
              <img :src="item.img" alt="" class="site-image">
              <div class="site-status" :class="item.status === '运行中' ? 'status-running' : 'status-closed'">
                {{ item.status }}
              </div>
            </div>
            <div class="site-info">
              <h3 class="site-name">
                <el-icon class="icon"><Place /></el-icon>
                {{ item.name }}
              </h3>
              <div class="info-row">
                <el-icon class="icon"><User /></el-icon>
                <span>负责人：{{ item.managerName }}</span>
              </div>
              <div class="info-row">
                <el-icon class="icon"><Iphone /></el-icon>
                <span>联系方式：{{ item.managerPhone }}</span>
              </div>
              <div class="info-row">
                <el-icon class="icon"><Clock /></el-icon>
                <span>开放时间：{{ item.timeRange }}</span>
              </div>
              <el-button type="primary" class="view-details-btn">
                <el-icon><ArrowRight /></el-icon>
                查看详情
              </el-button>
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
import {ElMessage} from "element-plus";
import { Place, User, Iphone, Clock, ArrowRight, Open } from '@element-plus/icons-vue';

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
.recovery-site-header {
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

.recovery-sites-container {
  margin-bottom: 30px;
}

.site-card {
  margin-bottom: 30px;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  border: none;
  cursor: pointer;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.site-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 15px 30px rgba(76, 175, 80, 0.15);
}

.site-img-container {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.site-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: all 0.5s ease;
}

.site-card:hover .site-image {
  transform: scale(1.1);
}

.site-status {
  position: absolute;
  top: 15px;
  right: 15px;
  padding: 5px 12px;
  border-radius: 20px;
  color: white;
  font-size: 13px;
  font-weight: 600;
  z-index: 2;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.status-running {
  background: linear-gradient(135deg, #4CAF50, #2E7D32);
}

.status-closed {
  background: linear-gradient(135deg, #F44336, #C62828);
}

.site-info {
  padding: 20px;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.site-name {
  font-size: 20px;
  font-weight: 600;
  color: #333;
  margin: 0 0 15px 0;
  display: flex;
  align-items: center;
  transition: color 0.3s ease;
}

.site-card:hover .site-name {
  color: #4CAF50;
}

.site-name .icon {
  color: #4CAF50;
  margin-right: 8px;
  font-size: 20px;
}

.info-row {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
  color: #666;
  font-size: 14px;
}

.info-row .icon {
  color: #2196F3;
  margin-right: 8px;
}

.view-details-btn {
  margin-top: auto;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  border: none;
  border-radius: 20px;
  padding: 10px 0;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
}

.view-details-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
  background: linear-gradient(135deg, #388E3C, #1976D2);
}
</style>