<template>
  <div class="feedback-container">
    <div class="feedback-card">
      <div class="card-header">
        <h1>提交反馈</h1>
        <p>您的每一条反馈都是我们进步的动力</p>
      </div>

      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="80px" class="feedback-form">
        <el-form-item label="标题" prop="title">
          <el-input 
            v-model="data.form.title" 
            placeholder="请输入反馈标题"
            class="custom-input">
          </el-input>
        </el-form-item>
        
        <el-form-item label="内容" prop="content">
          <el-input 
            type="textarea" 
            :rows="4" 
            v-model="data.form.content" 
            placeholder="请详细描述您遇到的问题或建议"
            class="custom-textarea">
          </el-input>
        </el-form-item>
        
        <el-form-item label="想法" prop="idea">
          <el-input 
            type="textarea" 
            :rows="4" 
            v-model="data.form.idea" 
            placeholder="请分享您对改进的建议和想法"
            class="custom-textarea">
          </el-input>
        </el-form-item>

        <div class="form-footer">
          <el-button 
            type="primary" 
            class="submit-button" 
            @click="add">
            <el-icon class="submit-icon"><Check /></el-icon>
            提交反馈
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
import { Check } from '@element-plus/icons-vue';

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
          ElMessage.success('提交成功')
          data.form = {}
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}
</script>

<style scoped>
.feedback-container {
  max-width: 800px;
  margin: 40px auto;
  padding: 0 20px;
}

.feedback-card {
  background: white;
  border-radius: 24px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  overflow: hidden;
}

.card-header {
  text-align: center;
  padding: 40px 40px 20px;
  background: linear-gradient(135deg, #f0f7f2, #e8f5e9);
}

.card-header h1 {
  font-size: 28px;
  color: #2c7a4d;
  margin-bottom: 12px;
  font-weight: 600;
}

.card-header p {
  color: #666;
  font-size: 16px;
}

.feedback-form {
  padding: 20px 40px 40px;
}

:deep(.el-form-item__label) {
  font-weight: 500;
  color: #2d3748;
  font-size: 15px;
}

.custom-input :deep(.el-input__wrapper) {
  background-color: #f8fafc;
  border-radius: 12px;
  box-shadow: none;
  padding: 8px 16px;
  transition: all 0.3s ease;
  border: 2px solid transparent;
}

.custom-input :deep(.el-input__wrapper:hover) {
  background-color: #f0f7f2;
  border-color: #65b57a;
}

.custom-input :deep(.el-input__wrapper.is-focus) {
  background-color: white;
  border-color: #65b57a;
  box-shadow: 0 0 0 4px rgba(101, 181, 122, 0.1);
}

.custom-textarea :deep(.el-textarea__inner) {
  background-color: #f8fafc;
  border-radius: 12px;
  box-shadow: none;
  padding: 16px;
  font-size: 15px;
  min-height: 120px !important;
  line-height: 1.6;
  transition: all 0.3s ease;
  border: 2px solid transparent;
}

.custom-textarea :deep(.el-textarea__inner:hover) {
  background-color: #f0f7f2;
  border-color: #65b57a;
}

.custom-textarea :deep(.el-textarea__inner:focus) {
  background-color: white;
  border-color: #65b57a;
  box-shadow: 0 0 0 4px rgba(101, 181, 122, 0.1);
}

.form-footer {
  text-align: center;
  margin-top: 40px;
}

.submit-button {
  background: linear-gradient(135deg, #65b57a, #4caf50);
  border: none;
  border-radius: 30px;
  font-size: 16px;
  font-weight: 500;
  padding: 12px 40px;
  color: white;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(101, 181, 122, 0.2);
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.submit-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(101, 181, 122, 0.3);
}

.submit-button:active {
  transform: translateY(0);
  box-shadow: 0 2px 8px rgba(101, 181, 122, 0.2);
}

.submit-icon {
  font-size: 18px;
}

:deep(.el-form-item.is-error .el-input__wrapper),
:deep(.el-form-item.is-error .el-textarea__inner) {
  border-color: #f56c6c;
  box-shadow: 0 0 0 4px rgba(245, 108, 108, 0.1);
}

:deep(.el-form-item__error) {
  color: #f56c6c;
  font-size: 13px;
  margin-top: 4px;
}

:deep(.el-form-item) {
  margin-bottom: 25px;
}

@media (max-width: 768px) {
  .feedback-container {
    margin: 20px auto;
  }
  
  .card-header {
    padding: 30px 20px 15px;
  }
  
  .card-header h1 {
    font-size: 24px;
  }
  
  .feedback-form {
    padding: 15px 20px 30px;
  }
  
  .submit-button {
    width: 100%;
    justify-content: center;
  }
}
</style>