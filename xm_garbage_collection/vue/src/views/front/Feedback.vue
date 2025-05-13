<template>
  <div class="main-content">
    <div class="feedback-header">
      <h2 class="section-title">用户反馈</h2>
      <div class="title-underline"></div>
      <p class="section-description">您的每一条建议都是我们进步的动力</p>
    </div>
    
    <div class="card feedback-card">
      <div class="feedback-icon-container">
        <div class="feedback-icon">
          <el-icon class="icon"><ChatLineRound /></el-icon>
        </div>
      </div>

      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="80px" class="feedback-form">
        <el-form-item label="标题" prop="title">
          <el-input v-model="data.form.title" placeholder="请简要描述您的反馈主题" class="feedback-input"></el-input>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input type="textarea" :rows="4" v-model="data.form.content" placeholder="请详细描述您遇到的问题或建议" class="feedback-input"></el-input>
        </el-form-item>
        <el-form-item label="想法" prop="idea">
          <el-input type="textarea" :rows="4" v-model="data.form.idea" placeholder="请分享您对改进的想法或建议" class="feedback-input"></el-input>
        </el-form-item>
        
        <div class="feedback-tips">
          <div class="tip-item">
            <el-icon class="tip-icon"><InfoFilled /></el-icon>
            <span>我们重视每一条用户反馈，并会在3个工作日内回复</span>
          </div>
          <div class="tip-item">
            <el-icon class="tip-icon"><Star /></el-icon>
            <span>优质反馈将获得积分奖励</span>
          </div>
        </div>
        
        <div class="form-actions">
          <el-button class="reset-button" @click="resetForm">重置</el-button>
          <el-button type="primary" class="submit-button" @click="add">
            <el-icon><Check /></el-icon>
            <span>提交反馈</span>
          </el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";
import { ChatLineRound, InfoFilled, Star, Check } from '@element-plus/icons-vue';

const formRef = ref()

const data = reactive({
  form: {},
  rules: {
    title: [
      { required: true, message: '请输入反馈标题', trigger: 'blur' }
    ],
    content: [
      { required: true, message: '请输入反馈内容', trigger: 'blur' }
    ],
    idea: [
      { required: true, message: '请输入您的想法', trigger: 'blur' }
    ]
  }
})

const add = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      request.post('/feedback/add', data.form).then(res => {
        if (res.code === '200') {
          ElMessage.success('反馈提交成功，感谢您的宝贵意见！')
          resetForm()
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

const resetForm = () => {
  formRef.value.resetFields()
  data.form = {}
}
</script>

<style scoped>
.feedback-header {
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

.feedback-card {
  padding: 40px;
  border: none;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  width: 650px;
  margin: 0 auto;
  position: relative;
}

.feedback-icon-container {
  display: flex;
  justify-content: center;
  margin-bottom: 30px;
}

.feedback-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background: linear-gradient(135deg, #2196F3, #4CAF50);
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0 8px 16px rgba(33, 150, 243, 0.2);
}

.icon {
  font-size: 40px;
  color: white;
}

.feedback-form {
  margin-top: 20px;
}

.feedback-input :deep(.el-input__wrapper),
.feedback-input :deep(.el-textarea__wrapper) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05) !important;
  border-radius: 12px !important;
  padding: 8px 15px;
  transition: all 0.3s ease;
}

.feedback-input :deep(.el-input__wrapper):hover,
.feedback-input :deep(.el-textarea__wrapper):hover {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.15) !important;
  transform: translateY(-2px);
}

.feedback-input :deep(.el-input__wrapper):focus-within,
.feedback-input :deep(.el-textarea__wrapper):focus-within {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2) !important;
  transform: translateY(-2px);
}

.feedback-tips {
  background-color: rgba(33, 150, 243, 0.05);
  border-radius: 12px;
  padding: 15px;
  margin: 20px 0;
  border-left: 4px solid #2196F3;
}

.tip-item {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}

.tip-item:last-child {
  margin-bottom: 0;
}

.tip-icon {
  color: #2196F3;
  margin-right: 8px;
  font-size: 16px;
}

.form-actions {
  display: flex;
  justify-content: center;
  gap: 15px;
  margin-top: 25px;
}

.submit-button {
  width: 160px;
  height: 45px;
  border-radius: 12px !important;
  font-size: 16px;
  font-weight: 500;
  background: linear-gradient(135deg, #4CAF50, #2196F3) !important;
  border: none !important;
  box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3) !important;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
}

.submit-button:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4) !important;
  background: linear-gradient(135deg, #388E3C, #1976D2) !important;
}

.reset-button {
  width: 110px;
  height: 45px;
  border-radius: 12px !important;
  font-size: 16px;
  transition: all 0.3s ease;
  border: 1px solid #ddd;
}

.reset-button:hover {
  border-color: #999;
  color: #666;
  background-color: #f5f5f5;
}
</style>