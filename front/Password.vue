<template>
  <div class="main-content">
    <div class="password-header">
      <h2 class="section-title">修改密码</h2>
      <div class="title-underline"></div>
      <p class="section-description">为了保障账户安全，建议定期更换密码</p>
    </div>
    
    <div class="card password-card">
      <div class="card-icon-container">
        <div class="card-icon">
          <el-icon class="lock-icon"><Lock /></el-icon>
        </div>
      </div>
      
      <el-form ref="formRef" :rules="data.rules" :model="data.user" label-width="100px" class="password-form">
        <el-form-item label="原密码" prop="password">
          <el-input v-model="data.user.password" placeholder="请输入原密码" show-password class="password-input"></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input v-model="data.user.newPassword" placeholder="请输入新密码" show-password class="password-input"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="data.user.confirmPassword" placeholder="请确认新密码" show-password class="password-input"></el-input>
        </el-form-item>
        
        <div class="password-tip">
          <el-icon><InfoFilled /></el-icon>
          <span>密码修改成功后将自动退出登录</span>
        </div>
        
        <div class="form-actions">
          <el-button class="cancel-button" @click="router.back()">取消</el-button>
          <el-button type="primary" class="save-button" @click="updatePassword">保存修改</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import {reactive, ref} from "vue";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";
import router from "@/router/index.js";
import { Lock, InfoFilled } from '@element-plus/icons-vue';

const formRef = ref()

const validatePass = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请确认密码'))
  } else {
    if (value !== data.user.newPassword) {
      callback(new Error("确认密码跟原密码不一致!"))
    }
    callback()
  }
}
const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  rules: {
    password: [
      { required: true, message: '请输入原密码', trigger: 'blur' },
    ],
    newPassword: [
      { required: true, message: '请输入新密码', trigger: 'blur' },
    ],
    confirmPassword: [
      { validator: validatePass, trigger: 'blur' }
    ]
  }
})

const updatePassword = () => {
  formRef.value.validate(valid => {
    if (valid) {
      request.put('/updatePassword', data.user).then(res => {
        if (res.code === '200') {
          ElMessage.success('密码修改成功，请重新登录')
          logout()
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

const logout = () => {
  localStorage.removeItem('xm-user')
  router.push('/login')
}
</script>

<style scoped>
.password-header {
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

.password-card {
  padding: 40px;
  border: none;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  width: 500px;
  margin: 0 auto;
  position: relative;
}

.card-icon-container {
  display: flex;
  justify-content: center;
  margin-bottom: 30px;
}

.card-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0 8px 16px rgba(33, 150, 243, 0.2);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    box-shadow: 0 0 0 0 rgba(33, 150, 243, 0.4);
  }
  70% {
    box-shadow: 0 0 0 10px rgba(33, 150, 243, 0);
  }
  100% {
    box-shadow: 0 0 0 0 rgba(33, 150, 243, 0);
  }
}

.lock-icon {
  font-size: 40px;
  color: white;
}

.password-form {
  margin-top: 20px;
}

.password-input :deep(.el-input__wrapper) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05) !important;
  border-radius: 12px !important;
  padding: 8px 15px;
  transition: all 0.3s ease;
}

.password-input :deep(.el-input__wrapper):hover {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.15) !important;
  transform: translateY(-2px);
}

.password-input :deep(.el-input__wrapper):focus-within {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2) !important;
  transform: translateY(-2px);
}

.password-tip {
  font-size: 14px;
  color: #666;
  margin: 15px 0 25px;
  padding: 10px 15px;
  background-color: rgba(255, 215, 0, 0.1);
  border-radius: 8px;
  display: flex;
  align-items: center;
}

.password-tip .el-icon {
  color: #FFD700;
  margin-right: 8px;
  font-size: 16px;
}

.form-actions {
  display: flex;
  justify-content: center;
  gap: 15px;
}

.save-button {
  width: 140px;
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

.cancel-button {
  width: 100px;
  height: 45px;
  border-radius: 12px !important;
  font-size: 16px;
  transition: all 0.3s ease;
  border: 1px solid #ddd;
}

.cancel-button:hover {
  border-color: #999;
  color: #666;
  background-color: #f5f5f5;
}
</style>