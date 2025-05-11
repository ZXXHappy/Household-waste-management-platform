<template>
  <div class="main-content">
    <div class="profile-header">
      <h2 class="section-title">个人信息</h2>
      <div class="title-underline"></div>
      <p class="section-description">您可以在这里查看和修改个人信息</p>
    </div>
    
    <div class="card profile-card">
      <el-form ref="user" :model="data.user" label-width="100px" class="profile-form">
        <div class="avatar-container">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :on-success="handleFileUpload"
              :show-file-list="false"
              class="avatar-uploader"
          >
            <div class="avatar-wrapper">
              <img v-if="data.user.avatar" :src="data.user.avatar" class="avatar" />
              <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
              <div class="avatar-hover-text">点击更换</div>
            </div>
          </el-upload>
        </div>
        
        <div class="form-content">
          <el-form-item prop="username" label="用户名">
            <el-input disabled v-model="data.user.username" placeholder="请输入用户名" class="profile-input"></el-input>
          </el-form-item>
          <el-form-item prop="name" label="姓名">
            <el-input v-model="data.user.name" placeholder="请输入姓名" class="profile-input"></el-input>
          </el-form-item>
          <el-form-item prop="phone" label="电话">
            <el-input v-model="data.user.phone" placeholder="请输入电话" class="profile-input"></el-input>
          </el-form-item>
          <el-form-item prop="email" label="邮箱">
            <el-input v-model="data.user.email" placeholder="请输入邮箱" class="profile-input"></el-input>
          </el-form-item>
          <el-form-item prop="score" label="剩余积分">
            <div class="score-display">
              <span class="score-value">{{ data.user.score }}</span>
              <el-tag type="warning" class="score-tag">积分</el-tag>
            </div>
          </el-form-item>
        </div>
        
        <div class="form-actions">
          <el-button type="primary" class="save-button" @click="update">保 存</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";
import { Plus } from '@element-plus/icons-vue';

const baseUrl = import.meta.env.VITE_BASE_URL

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}')
})

const handleFileUpload = (res) => {
  data.user.avatar = res.data
}

// 更新用户最新的积分
request.get('/user/selectById/' + data.user.id).then(res=> {
  data.user.score = res.data.score
})

const emit = defineEmits(['updateUser'])
const update = () => {
  request.put('/user/update', data.user).then(res => {
    if (res.code === '200') {
      ElMessage.success('保存成功')
      localStorage.setItem('xm-user', JSON.stringify(data.user))
      emit('updateUser')
    } else {
      ElMessage.error(res.msg)
    }
  })
}
</script>

<style scoped>
.profile-header {
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

.profile-card {
  padding: 40px;
  border: none;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  width: 500px;
  margin: 0 auto;
}

.profile-form {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.avatar-container {
  margin-bottom: 30px;
  position: relative;
}

.avatar-wrapper {
  position: relative;
  overflow: hidden;
  border-radius: 50%;
  width: 140px;
  height: 140px;
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.avatar-wrapper:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(33, 150, 243, 0.2);
}

.avatar-hover-text {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(33, 150, 243, 0.8);
  color: white;
  padding: 5px 0;
  text-align: center;
  font-size: 12px;
  opacity: 0;
  transition: all 0.3s ease;
  transform: translateY(100%);
}

.avatar-wrapper:hover .avatar-hover-text {
  opacity: 1;
  transform: translateY(0);
}

.avatar {
  width: 140px;
  height: 140px;
  object-fit: cover;
  border-radius: 50%;
}

.form-content {
  width: 100%;
}

.profile-input :deep(.el-input__wrapper) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05) !important;
  border-radius: 12px !important;
  padding: 8px 15px;
  transition: all 0.3s ease;
}

.profile-input :deep(.el-input__wrapper):hover {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.15) !important;
  transform: translateY(-2px);
}

.profile-input :deep(.el-input__wrapper):focus-within {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2) !important;
  transform: translateY(-2px);
}

.score-display {
  display: flex;
  align-items: center;
}

.score-value {
  font-size: 24px;
  font-weight: bold;
  color: #FFD700;
  margin-right: 10px;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.score-tag {
  background: linear-gradient(135deg, #FFD700, #F5CB00) !important;
  color: #333 !important;
  font-weight: bold;
  border: none;
}

.form-actions {
  margin-top: 20px;
  width: 100%;
  display: flex;
  justify-content: center;
}

.save-button {
  width: 180px;
  height: 45px;
  border-radius: 12px !important;
  font-size: 16px;
  font-weight: 500;
  background: linear-gradient(135deg, #4CAF50, #2196F3) !important;
  border: none !important;
  box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3) !important;
  transition: all 0.3s ease;
}

.save-button:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4) !important;
  background: linear-gradient(135deg, #388E3C, #1976D2) !important;
}
</style>

<style>
.avatar-uploader .el-upload {
  border: 2px dashed rgba(76, 175, 80, 0.3);
  border-radius: 50%;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
}

.avatar-uploader .el-upload:hover {
  border-color: #4CAF50;
  background-color: rgba(76, 175, 80, 0.05);
}

.el-icon.avatar-uploader-icon {
  font-size: 32px;
  color: #4CAF50;
  width: 140px;
  height: 140px;
  text-align: center;
  line-height: 140px;
}
</style>