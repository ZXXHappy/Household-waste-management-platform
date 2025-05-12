<template>
  <div class="person-container">
    <div class="card profile-card">
      <div class="profile-header">
        <el-icon><User /></el-icon>
        <h2>个人资料</h2>
      </div>
      
      <el-form ref="user" :model="data.user" label-width="80px" class="profile-form">
        <div class="avatar-section">
          <el-upload
            :action="baseUrl + '/files/upload'"
            :on-success="handleFileUpload"
            :show-file-list="false"
            :headers="{ 'token': data.user.token }"
            class="avatar-uploader"
          >
            <div class="avatar-wrapper">
              <img v-if="data.user.avatar" :src="data.user.avatar" class="avatar" />
              <div v-else class="avatar-placeholder">
                <el-icon><Avatar /></el-icon>
              </div>
              <div class="avatar-overlay">
                <el-icon><Camera /></el-icon>
                <span>点击更换</span>
              </div>
            </div>
          </el-upload>
          <div class="user-role">
            <el-tag effect="dark" :type="getRoleType(data.user.role)">{{ data.user.role }}</el-tag>
          </div>
        </div>
        
        <div class="form-section">
          <el-form-item prop="username" label="用户名">
            <el-input disabled v-model="data.user.username" placeholder="请输入用户名">
              <template #prefix>
                <el-icon><UserFilled /></el-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item prop="name" label="姓名">
            <el-input v-model="data.user.name" placeholder="请输入姓名">
              <template #prefix>
                <el-icon><Edit /></el-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item prop="phone" label="电话">
            <el-input v-model="data.user.phone" placeholder="请输入电话">
              <template #prefix>
                <el-icon><Phone /></el-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item prop="email" label="邮箱">
            <el-input v-model="data.user.email" placeholder="请输入邮箱">
              <template #prefix>
                <el-icon><Message /></el-icon>
              </template>
            </el-input>
          </el-form-item>
          
          <div class="form-actions">
            <el-button type="primary" @click="update" :loading="data.loading">
              <el-icon><Check /></el-icon>保存修改
            </el-button>
          </div>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import { ElMessage } from "element-plus";
import { User, UserFilled, Edit, Phone, Message, Check, Camera, Avatar } from "@element-plus/icons-vue";

const baseUrl = import.meta.env.VITE_BASE_URL

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  loading: false
})

const handleFileUpload = (res) => {
  data.user.avatar = res.data
}

const getRoleType = (role) => {
  switch (role) {
    case 'ADMIN': return 'danger';
    case 'COMMUNITY': return 'success';
    case 'USER': return 'info';
    default: return 'primary';
  }
}

const emit = defineEmits(['updateUser'])
const update = () => {
  data.loading = true;
  if (data.user.role === 'ADMIN') {
    request.put('/admin/update', data.user).then(res => {
      data.loading = false;
      if (res.code === '200') {
        ElMessage.success('保存成功')
        localStorage.setItem('xm-user', JSON.stringify(data.user))
        emit('updateUser')
      } else {
        ElMessage.error(res.msg)
      }
    }).catch(() => {
      data.loading = false;
    })
  } else if (data.user.role === 'COMMUNITY') {
    request.put('/communityAdmin/update', data.user).then(res => {
      data.loading = false;
      if (res.code === '200') {
        ElMessage.success('保存成功')
        localStorage.setItem('xm-user', JSON.stringify(data.user))
        emit('updateUser')
      } else {
        ElMessage.error(res.msg)
      }
    }).catch(() => {
      data.loading = false;
    })
  }
}
</script>

<style scoped>
.person-container {
  display: flex;
  justify-content: center;
}

.profile-card {
  width: 100%;
  max-width: 700px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 0;
  overflow: hidden;
}

.profile-header {
  display: flex;
  align-items: center;
  padding: 16px 20px;
  background-color: #f8fafc;
  border-bottom: 1px solid #ebeef5;
}

.profile-header .el-icon {
  font-size: 20px;
  color: #409eff;
  margin-right: 10px;
}

.profile-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
  color: #303133;
}

.profile-form {
  padding: 30px 20px;
  display: flex;
  flex-wrap: wrap;
}

.avatar-section {
  width: 200px;
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-right: 30px;
}

.avatar-wrapper {
  position: relative;
  width: 150px;
  height: 150px;
  border-radius: 50%;
  overflow: hidden;
  margin-bottom: 15px;
  box-shadow: 0 3px 12px rgba(0, 0, 0, 0.1);
  cursor: pointer;
}

.avatar {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.avatar-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f5f7fa;
}

.avatar-placeholder .el-icon {
  font-size: 60px;
  color: #c0c4cc;
}

.avatar-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  opacity: 0;
  transition: opacity 0.3s;
}

.avatar-wrapper:hover .avatar-overlay {
  opacity: 1;
}

.avatar-overlay .el-icon {
  font-size: 24px;
  color: #fff;
  margin-bottom: 5px;
}

.avatar-overlay span {
  color: #fff;
  font-size: 14px;
}

.user-role {
  margin-top: 10px;
}

.form-section {
  flex: 1;
  min-width: 300px;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}

@media (max-width: 768px) {
  .profile-form {
    flex-direction: column;
  }
  
  .avatar-section {
    width: 100%;
    margin-right: 0;
    margin-bottom: 30px;
  }
}
</style>