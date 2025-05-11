<template>
  <div style="width: 50%; margin: 10px auto">
    <div class="card" style="padding: 30px 20px">
      <div style="font-size: 24px; text-align: center; margin-bottom: 30px">请提交您的反馈</div>

      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="data.form.title" placeholder="请输入反馈标题"></el-input>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input type="textarea" :rows="3" v-model="data.form.content" placeholder="请输入反馈标题"></el-input>
        </el-form-item>
        <el-form-item label="想法" prop="idea">
          <el-input type="textarea" :rows="3" v-model="data.form.idea" placeholder="请输入反馈标题"></el-input>
        </el-form-item>
      </el-form>

      <div style="text-align: center">
        <el-button type="primary" style="padding: 20px 40px" @click="add">提交反馈</el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";

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

</style>