<template>
  <div class="login-container">
    <div class="login-card">
      <div class="login-title">欢迎登录</div>
      <el-form ref="formRef" :model="data.form" :rules="data.rules" class="login-form">
        <el-form-item prop="username">
          <el-input v-model="data.form.username" size="large" placeholder="请输入账号" :prefix-icon="User" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="data.form.password" size="large" type="password" show-password placeholder="请输入密码" :prefix-icon="Lock" />
        </el-form-item>
        <el-form-item prop="role">
          <el-select v-model="data.form.role" size="large" placeholder="请选择身份">
            <el-option value="USER" label="普通用户" />
            <el-option value="ADMIN" label="管理员" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="large" class="login-button" @click="login">登 录</el-button>
        </el-form-item>
        <div class="login-footer">
          还没有账号？请 <a href="/register">注册</a>
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

const data = reactive({
  dialogVisible: true,
  form: { role: 'USER' },
  rules: {
    username: [
      { required: true, message: '请输入账号', trigger: 'blur' }
    ],
    password: [
      { required: true, message: '请输入密码', trigger: 'blur' }
    ]
  }
})

const formRef = ref()

const login = () => {
  formRef.value.validate(valid => {
    if (valid) { // 表示表单校验通过
      request.post('/login', data.form).then(res => {
        if (res.code === '200') {
          ElMessage.success('登录成功')
          // 存储用户信息到浏览器的缓存
          localStorage.setItem('xm-user', JSON.stringify(res.data))
          if (res.data.role === 'USER') {
            router.push('/front/home')
          } else if (res.data.role === 'ADMIN') {
            router.push('/manager/home')
          }
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}
</script>

<style scoped>
.login-container {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #e0f7fa, #e8f5e9);
  background-size: cover;
  overflow: hidden;
  background-image: url("@/assets/imgs/bg1.jpg");
}

.login-card {
  width: 400px;
  padding: 40px 30px;
  border-radius: 16px;
  background-color: #ffffffcc; /* 半透明白 */
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
}

.login-title {
  font-size: 28px;
  font-weight: bold;
  color: #4caf50;
  text-align: center;
  margin-bottom: 30px;
  letter-spacing: 2px;
}

.login-button {
  width: 100%;
  background-color: #4caf50;
  border: none;
  font-weight: bold;
  letter-spacing: 1px;
}

.login-button:hover {
  background-color: #43a047;
}

.login-footer {
  text-align: right;
  font-size: 14px;
  color: #555;
  margin-top: -10px;
}

.login-footer a {
  color: #4caf50;
  font-weight: 500;
  text-decoration: none;
}

.login-footer a:hover {
  text-decoration: underline;
}
</style>
