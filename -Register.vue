<template>
  <div class="register-container">
    <div class="register-card">
      <div class="register-title">欢迎注册</div>
      <el-form ref="formRef" :model="data.form" :rules="data.rules" class="register-form">
        <el-form-item prop="username">
          <el-input v-model="data.form.username" size="large" placeholder="请输入账号" :prefix-icon="User" />
        </el-form-item>
        <el-form-item prop="name">
          <el-input v-model="data.form.name" size="large" placeholder="请输入姓名" :prefix-icon="User" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="data.form.password" size="large" type="password" show-password placeholder="请输入密码" :prefix-icon="Lock" />
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input v-model="data.form.confirmPassword" size="large" type="password" show-password placeholder="请确认密码" :prefix-icon="Lock" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="large" class="register-button" @click="register">注 册</el-button>
        </el-form-item>
        <div class="register-footer">
          已有账号？请 <a href="/login">登录</a>
        </div>
      </el-form>
    </div>
  </div>
</template>


<script setup>
import { reactive, ref } from "vue";
import { User, Lock } from "@element-plus/icons-vue";
//import request from "@/utils/request.js";
import {ElMessage} from "element-plus";
import router from "@/router/index.js";

const validatePass = (rule, value, callback) => {
  if (!value) {
    callback(new Error('请确认密码'))
  } else {
    if (value !== data.form.password) {
      callback(new Error("确认密码跟原密码不一致!"))
    }
    callback()
  }
}
const data = reactive({
  form: { },
  rules: {
    username: [
      { required: true, message: '请输入账号', trigger: 'blur' }
    ],
    password: [
      { required: true, message: '请输入密码', trigger: 'blur' }
    ],
    confirmPassword: [
      { validator: validatePass, trigger: 'blur' }
    ]
  }
})

const formRef = ref()

const login = () => {
  formRef.value.validate(valid => {
    if (valid) { // 表示表单校验通过
      request.post('/register', data.form).then(res => {
        if (res.code === '200') {
          ElMessage.success('注册成功')
          router.push('/login')
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}
</script>

<style scoped>
.register-container {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #e0f7fa, #e8f5e9);
  background-size: cover;
  background-image: url("@/assets/imgs/bg1.jpg");
}

.register-card {
  width: 420px;
  padding: 40px 30px;
  border-radius: 16px;
  background-color: rgba(255, 255, 255, 0.9);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
  backdrop-filter: blur(10px);
}

.register-title {
  font-size: 28px;
  font-weight: bold;
  color: #4caf50;
  text-align: center;
  margin-bottom: 30px;
  letter-spacing: 2px;
}

.register-button {
  width: 100%;
  background-color: #4caf50;
  border: none;
  font-weight: bold;
  letter-spacing: 1px;
}

.register-button:hover {
  background-color: #43a047;
}

.register-footer {
  text-align: right;
  font-size: 14px;
  color: #555;
  margin-top: -10px;
}

.register-footer a {
  color: #4caf50;
  font-weight: 500;
  text-decoration: none;
}

.register-footer a:hover {
  text-decoration: underline;
}
</style>
