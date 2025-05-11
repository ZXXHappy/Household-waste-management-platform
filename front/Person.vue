<template>
  <div class="main-content">
    <div class="page-header">
      <h1>个人信息</h1>
    </div>
    <div class="card">
      <el-form 
        ref="user" 
        :model="data.user" 
        label-width="80px" 
        class="person-form"
      >
        <div class="avatar-container">
          <el-upload
            :action="baseUrl + '/files/upload'"
            :on-success="handleFileUpload"
            :show-file-list="false"
            class="avatar-uploader"
          >
            <img v-if="data.user.avatar" :src="data.user.avatar" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
          <div class="avatar-tip">点击更换头像</div>
        </div>

        <el-form-item prop="username" label="用户名">
          <el-input 
            disabled 
            v-model="data.user.username" 
            placeholder="请输入用户名"
            :prefix-icon="User">
          </el-input>
        </el-form-item>

        <el-form-item prop="name" label="姓名">
          <el-input 
            v-model="data.user.name" 
            placeholder="请输入姓名"
            :prefix-icon="User">
          </el-input>
        </el-form-item>

        <el-form-item prop="phone" label="电话">
          <el-input 
            v-model="data.user.phone" 
            placeholder="请输入电话"
            :prefix-icon="Phone">
          </el-input>
        </el-form-item>

        <el-form-item prop="email" label="邮箱">
          <el-input 
            v-model="data.user.email" 
            placeholder="请输入邮箱"
            :prefix-icon="Message">
          </el-input>
        </el-form-item>

        <el-form-item prop="score" label="剩余积分">
          <div class="score-display">
            <el-tag type="success" size="large">{{ data.user.score }}</el-tag>
          </div>
        </el-form-item>

        <div class="form-actions">
          <el-button type="primary" :icon="Check" @click="update">保 存</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";
import {Plus, User, Phone, Message, Check} from "@element-plus/icons-vue";

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
.main-content {
  max-width: 1000px;
  margin: 15px auto;
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
  font-size: 28px;
  color: #2c7a4d;
  font-weight: 600;
}

.card {
  background: white;
  border-radius: 15px;
  padding: 20px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
}

.person-form {
  max-width: 400px;
  margin: 0 auto;
}

.avatar-container {
  text-align: center;
  margin-bottom: 32px;
}

.avatar-uploader {
  display: inline-block;
}

.avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  object-fit: cover;
  border: 4px solid #fff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.avatar:hover {
  transform: scale(1.05);
}

.avatar-tip {
  margin-top: 8px;
  color: #666;
  font-size: 14px;
}

.avatar-uploader :deep(.el-upload) {
  border: 2px dashed #65b57a;
  border-radius: 50%;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
}

.avatar-uploader :deep(.el-upload:hover) {
  border-color: #4caf50;
  background-color: rgba(101, 181, 122, 0.05);
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #65b57a;
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
}

.score-display {
  display: flex;
  align-items: center;
}

.score-display :deep(.el-tag) {
  font-size: 16px;
  padding: 8px 16px;
  border-radius: 8px;
}

.form-actions {
  text-align: center;
  margin-top: 32px;
}

:deep(.el-input__wrapper) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

:deep(.el-input__wrapper:hover) {
  box-shadow: 0 2px 12px rgba(101, 181, 122, 0.1);
}

:deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 1px #65b57a;
}

:deep(.el-form-item__label) {
  font-weight: 500;
  color: #333;
}

@media (max-width: 768px) {
  .main-content {
    padding: 20px;
  }
  
  .card {
    padding: 20px;
  }
  
  .person-form {
    padding: 0;
  }
}
</style>