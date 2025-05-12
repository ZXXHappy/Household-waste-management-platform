<template>
  <div>
    <div class="welcome-card">
      <div class="welcome-info">
        <div class="welcome-avatar">
          <el-avatar :size="60" :src="data.user?.avatar">
            <el-icon><User /></el-icon>
          </el-avatar>
        </div>
        <div class="welcome-text">
          <h2>您好，{{ data.user?.name }}！</h2>
          <p>欢迎使用生活垃圾管理平台，祝您使用愉快！</p>
        </div>
      </div>
      <div class="welcome-stats">
        <div class="stats-card">
          <el-icon><Clock /></el-icon>
          <div class="stats-info">
            <div class="stats-value">{{ getCurrentTime() }}</div>
            <div class="stats-label">当前时间</div>
          </div>
        </div>
        <div class="stats-card">
          <el-icon><Calendar /></el-icon>
          <div class="stats-info">
            <div class="stats-value">{{ getCurrentDate() }}</div>
            <div class="stats-label">今日日期</div>
          </div>
        </div>
      </div>
    </div>
    
    <el-row :gutter="20" class="dashboard-row">
      <el-col :xs="24" :sm="24" :md="12">
        <div class="card notice-card">
          <div class="card-header">
            <el-icon><Bell /></el-icon>
            <h3>系统公告</h3>
          </div>
          <el-timeline v-if="data.noticeData.length">
            <el-timeline-item
              v-for="(item, index) in data.noticeData"
              :key="index"
              :timestamp="item.time"
              :type="getTimelineItemType(index)"
              :hollow="index % 2 === 0"
            >
              <div class="notice-content">{{ item.content }}</div>
            </el-timeline-item>
          </el-timeline>
          <div class="empty-notice" v-else>
            <el-empty description="暂无系统公告" />
          </div>
        </div>
      </el-col>
      
      <el-col :xs="24" :sm="24" :md="12">
        <div class="card quick-card">
          <div class="card-header">
            <el-icon><Menu /></el-icon>
            <h3>快捷入口</h3>
          </div>
          <div class="quick-links">
            <div class="quick-link-item" @click="navigateTo('/manager/person')">
              <el-icon><User /></el-icon>
              <span>个人资料</span>
            </div>
            <div class="quick-link-item" @click="navigateTo('/manager/password')">
              <el-icon><Lock /></el-icon>
              <span>修改密码</span>
            </div>
            <div class="quick-link-item" @click="navigateTo('/manager/community')">
              <el-icon><House /></el-icon>
              <span>社区信息</span>
            </div>
            <div class="quick-link-item" @click="navigateTo('/manager/recoverySite')">
              <el-icon><Location /></el-icon>
              <span>回收点信息</span>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import request from "@/utils/request.js";
import { ElMessage } from "element-plus";
import { User, Bell, Menu, Clock, Calendar, House, Location, Lock } from "@element-plus/icons-vue";
import router from "@/router/index.js";

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  noticeData: [],
  loading: false
})

const getCurrentTime = () => {
  const now = new Date();
  const hours = now.getHours().toString().padStart(2, '0');
  const minutes = now.getMinutes().toString().padStart(2, '0');
  return `${hours}:${minutes}`;
}

const getCurrentDate = () => {
  const now = new Date();
  const year = now.getFullYear();
  const month = (now.getMonth() + 1).toString().padStart(2, '0');
  const day = now.getDate().toString().padStart(2, '0');
  return `${year}-${month}-${day}`;
}

const getTimelineItemType = (index) => {
  const types = ['primary', 'success', 'warning', 'danger', 'info'];
  return types[index % types.length];
}

const navigateTo = (path) => {
  router.push(path);
}

const loadNotice = () => {
  data.loading = true;
  request.get('/notice/selectAll').then(res => {
    data.loading = false;
    if (res.code === '200') {
      data.noticeData = res.data;
    } else {
      ElMessage.error(res.msg);
    }
  }).catch(() => {
    data.loading = false;
  });
}

loadNotice();
</script>

<style scoped>
.welcome-card {
  background: linear-gradient(135deg, #ffffff, #f5f7fa);
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.welcome-info {
  display: flex;
  align-items: center;
}

.welcome-avatar {
  margin-right: 20px;
}

.welcome-text h2 {
  margin: 0 0 8px 0;
  font-size: 22px;
  color: #303133;
}

.welcome-text p {
  margin: 0;
  color: #606266;
}

.welcome-stats {
  display: flex;
  gap: 20px;
}

.stats-card {
  display: flex;
  align-items: center;
  padding: 15px;
  background-color: #ffffff;
  border-radius: 6px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.stats-card .el-icon {
  font-size: 24px;
  color: #409eff;
  margin-right: 15px;
}

.stats-info {
  display: flex;
  flex-direction: column;
}

.stats-value {
  font-size: 18px;
  font-weight: 500;
  color: #303133;
}

.stats-label {
  font-size: 12px;
  color: #909399;
  margin-top: 2px;
}

.dashboard-row {
  margin-bottom: 20px;
}

.card {
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  height: 100%;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
}

.card-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #ebeef5;
}

.card-header .el-icon {
  font-size: 20px;
  color: #409eff;
  margin-right: 10px;
}

.card-header h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
  color: #303133;
}

.notice-card {
  height: 400px;
  overflow-y: auto;
}

.notice-content {
  background-color: #f8fafc;
  padding: 12px;
  border-radius: 6px;
  margin-bottom: 8px;
  line-height: 1.5;
}

.empty-notice {
  height: 300px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.quick-card {
  height: 400px;
}

.quick-links {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px;
}

.quick-link-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: #f8fafc;
  border-radius: 6px;
  padding: 20px;
  cursor: pointer;
  transition: all 0.3s;
}

.quick-link-item:hover {
  background-color: #ecf5ff;
  transform: translateY(-3px);
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
}

.quick-link-item .el-icon {
  font-size: 24px;
  color: #409eff;
  margin-bottom: 10px;
}

.quick-link-item span {
  font-size: 14px;
  color: #606266;
}

@media (max-width: 768px) {
  .welcome-stats {
    margin-top: 20px;
    width: 100%;
    justify-content: space-around;
  }
  
  .quick-links {
    grid-template-columns: 1fr;
  }
}
</style>