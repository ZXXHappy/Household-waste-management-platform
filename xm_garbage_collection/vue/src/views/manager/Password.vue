<template>
  <div class="password-container">
    <div class="card password-card">
      <div class="password-header">
        <el-icon><Lock /></el-icon>
        <h2>修改密码</h2>
      </div>
      
      <el-form 
        ref="formRef" 
        :rules="data.rules" 
        :model="data.user" 
        label-width="90px" 
        class="password-form"
      >
        <el-alert
          title="密码修改成功后将自动退出登录"
          type="info"
          :closable="false"
          show-icon
          class="password-tip"
        />
        
        <el-form-item label="原密码" prop="password">
          <el-input 
            v-model="data.user.password" 
            placeholder="请输入原密码" 
            show-password
          >
            <template #prefix>
              <el-icon><Key /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        
        <el-form-item label="新密码" prop="newPassword">
          <el-input 
            v-model="data.user.newPassword" 
            placeholder="请输入新密码" 
            show-password
          >
            <template #prefix>
              <el-icon><EditPen /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input 
            v-model="data.user.confirmPassword" 
            placeholder="请确认新密码" 
            show-password
          >
            <template #prefix>
              <el-icon><Check /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        
        <div class="form-actions">
          <el-button @click="cancel">取消</el-button>
          <el-button type="primary" @click="updatePassword" :loading="data.loading">
            <el-icon><CircleCheck /></el-icon>保存修改
          </el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import request from "@/utils/request.js";
import { ElMessage } from "element-plus";
import router from "@/router/index.js";
import { Lock, Key, EditPen, Check, CircleCheck } from "@element-plus/icons-vue";

const formRef = ref()

const validatePass = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请确认密码'))
  } else {
    if (value !== data.user.newPassword) {
      callback(new Error("确认密码与新密码不一致!"))
    }
    callback()
  }
}

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  loading: false,
  rules: {
    password: [
      { required: true, message: '请输入原密码', trigger: 'blur' },
    ],
    newPassword: [
      { required: true, message: '请输入新密码', trigger: 'blur' },
      { min: 6, message: '密码长度不能少于6个字符', trigger: 'blur' }
    ],
    confirmPassword: [
      { validator: validatePass, trigger: 'blur' }
    ]
  }
})

const updatePassword = () => {
  formRef.value.validate(valid => {
    if (valid) {
      data.loading = true;
      request.put('/updatePassword', data.user).then(res => {
        data.loading = false;
        if (res.code === '200') {
          ElMessage.success('密码修改成功，即将退出登录...')
          setTimeout(() => {
            logout();
          }, 1500);
        } else {
          ElMessage.error(res.msg)
        }
      }).catch(() => {
        data.loading = false;
      })
    }
  })
}

const cancel = () => {
  router.back();
}

const logout = () => {
  localStorage.removeItem('xm-user')
  router.push('/login')
}
</script>

<style scoped>
.password-container {
  display: flex;
  justify-content: center;
}

.password-card {
  width: 100%;
  max-width: 550px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 0;
  overflow: hidden;
}

.password-header {
  display: flex;
  align-items: center;
  padding: 16px 20px;
  background-color: #f8fafc;
  border-bottom: 1px solid #ebeef5;
}

.password-header .el-icon {
  font-size: 20px;
  color: #409eff;
  margin-right: 10px;
}

.password-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
  color: #303133;
}

.password-form {
  padding: 30px 20px;
}

.password-tip {
  margin-bottom: 20px;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 30px;
  gap: 10px;
}
</style>