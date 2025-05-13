<template>
  <div class="main-content">
    <div class="site-detail-header">
      <div class="breadcrumb">
        <el-link :underline="false" @click="router.go(-1)" class="back-link">
          <el-icon><ArrowLeft /></el-icon>
          <span>返回</span>
        </el-link>
        <div class="breadcrumb-path">
          <div class="breadcrumb-item">
            <el-icon><House /></el-icon>
            <span>{{ data.recoverySite.communityName }}</span>
          </div>
          <div class="separator-arrow">
            <el-icon><ArrowRight /></el-icon>
          </div>
          <div class="breadcrumb-item current">
            <el-icon><Place /></el-icon>
            <span>{{ data.recoverySite.name }}</span>
          </div>
        </div>
      </div>
      
      <div class="site-banner">
        <img :src="data.recoverySite.img" alt="" class="site-image">
        <div class="site-banner-overlay"></div>
      </div>
    </div>

    <div class="site-content-container">
      <div class="site-sidebar">
        <div class="sidebar-header">
          <h3>可回收物品</h3>
          <div class="recycling-icon">
            <el-icon><Goods /></el-icon>
          </div>
        </div>
        <div class="recyclable-items">
          <div v-for="item in data.recycleGarbageList" :key="item.id" class="card recyclable-card">
            <div class="recyclable-img">
              <img :src="item.img" alt="">
            </div>
            <div class="recyclable-info">
              <h4 class="recyclable-name">{{ item.name }}</h4>
              <div class="recyclable-desc">{{ item.descr }}</div>
              <div class="recyclable-points">
                <el-icon><GoldMedal /></el-icon>
                <span>{{ item.points }}积分/{{ item.unit }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="site-main-content">
        <div class="card site-info-card">
          <div class="card-header">
            <h3 class="site-title">{{ data.recoverySite.name }}</h3>
            <div class="action-buttons">
              <el-button type="primary" @click="handleAdd" class="action-btn disposal-btn">
                <el-icon><Delete /></el-icon>
                投放垃圾
              </el-button>
              <el-button type="success" @click="handleAdd1" class="action-btn recycling-btn">
                <el-icon><Refresh /></el-icon>
                回收申请
              </el-button>
            </div>
          </div>
          
          <div class="site-details">
            <div class="detail-item">
              <el-icon class="detail-icon"><House /></el-icon>
              <span class="detail-label">所属社区：</span>
              <span class="detail-value">{{ data.recoverySite.communityName }}</span>
            </div>
            <div class="detail-item">
              <el-icon class="detail-icon"><Clock /></el-icon>
              <span class="detail-label">开放时间：</span>
              <span class="detail-value">{{ data.recoverySite.timeRange }}</span>
            </div>
            <div class="detail-item">
              <el-icon class="detail-icon"><Avatar /></el-icon>
              <span class="detail-label">负责人：</span>
              <span class="detail-value">{{ data.recoverySite.managerName }}</span>
            </div>
            <div class="detail-item">
              <el-icon class="detail-icon"><Phone /></el-icon>
              <span class="detail-label">联系电话：</span>
              <span class="detail-value">{{ data.recoverySite.managerPhone }}</span>
            </div>
          </div>
        </div>

        <div class="card site-content-card">
          <div class="content-header">
            <h3>回收点详情</h3>
          </div>
          <div class="site-content">
            <div v-html="data.recoverySite.content"></div>
          </div>
        </div>
      </div>
    </div>

    <el-dialog title="投放垃圾" v-model="data.formVisible" width="40%" destroy-on-close class="custom-dialog disposal-dialog">
      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="100px" class="dialog-form">
        <el-form-item prop="img" label="垃圾照片">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload"
              list-type="picture"
              class="custom-upload"
          >
            <div class="upload-btn">
              <el-icon><Upload /></el-icon>
              <span>上传垃圾照片</span>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item prop="type" label="垃圾类型">
          <el-select placeholder="请选择垃圾的类型" v-model="data.form.type" class="custom-select">
            <el-option label="干垃圾" value="干垃圾"></el-option>
            <el-option label="湿垃圾" value="湿垃圾"></el-option>
            <el-option label="有害垃圾" value="有害垃圾"></el-option>
            <el-option label="厨余垃圾" value="厨余垃圾"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false" class="cancel-btn">取 消</el-button>
          <el-button type="primary" @click="add" class="confirm-btn">
            <el-icon><Check /></el-icon>
            确 定
          </el-button>
        </span>
      </template>
    </el-dialog>

    <el-dialog title="垃圾回收申请" v-model="data.formVisible1" width="40%" destroy-on-close class="custom-dialog recycling-dialog">
      <el-form ref="formRef1" :model="data.form1" :rules="data.rules1" label-width="140px" class="dialog-form">
        <el-form-item prop="garbageId" label="可回收垃圾类型">
          <el-select @change="calScore" placeholder="请选择可回收垃圾的类型" v-model="data.form1.garbageId" class="custom-select">
            <el-option v-for="item in data.recycleGarbageList" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="img" label="垃圾照片">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload1"
              list-type="picture"
              class="custom-upload"
          >
            <div class="upload-btn">
              <el-icon><Upload /></el-icon>
              <span>上传垃圾照片</span>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item prop="num" label="回收数量">
          <div class="num-input-wrapper">
            <el-input-number @change="calScore" v-model="data.form1.num" :min="1" placeholder="请输入数量" class="custom-number"></el-input-number>
            <span class="unit-tag">{{ data.form1.unit || '单位' }}</span>
          </div>
        </el-form-item>
        <el-form-item prop="score" label="可获得积分">
          <div class="score-display">
            <span class="score-value">{{ data.form1.score || 0 }}</span>
            <el-icon class="score-icon"><GoldMedal /></el-icon>
          </div>
        </el-form-item>
        <el-form-item prop="remark" label="备注">
          <el-input type="textarea" :rows="3" v-model="data.form1.remark" placeholder="请输入备注" class="custom-textarea"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible1 = false" class="cancel-btn">取 消</el-button>
          <el-button type="primary" @click="addRecovery" class="confirm-btn">
            <el-icon><Check /></el-icon>
            确 定
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";
import { 
  ArrowLeft, Goods, GoldMedal, Delete, Refresh, 
  House, Clock, Avatar, Phone, Upload, Check, ArrowRight, Place 
} from '@element-plus/icons-vue';

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  id: router.currentRoute.value.query.id,
  recoverySite: {},
  recycleGarbageList: [],
  formVisible: false,
  form: {},
  rules: {
    type: [
      { required: true, message: '请输入垃圾类型', trigger: 'change' }
    ]
  },
  formVisible1: false,
  form1: {},
  rules1: {
    garbageId: [
      { required: true, message: '请选择可回收垃圾类型', trigger: 'change' }
    ]
  },
})

const formRef = ref()
const formRef1 = ref()

const calScore = () => {
  if (data.form1.garbageId) {
    let garbage =  data.recycleGarbageList.find(v => v.id === data.form1.garbageId)
    let points = garbage?.points || 0
    data.form1.score = data.form1.num * points
    data.form1.unit = garbage.unit
  }
}

const baseUrl = import.meta.env.VITE_BASE_URL
const handleFileUpload = (res) => {
  data.form.img = res.data
}

const handleFileUpload1 = (res) => {
  data.form1.img = res.data
}

const addRecovery = () => {
  formRef1.value.validate((valid) => {
    if (valid) {
      if (!data.form1.img) {
        ElMessage.warning('请上传可回收垃圾图片')
        return
      }
      data.form1.communityId = data.recoverySite.communityId
      data.form1.siteId = data.recoverySite.id
      request.post('/recoveryRecords/add', data.form1).then(res => {
        if (res.code === '200') {
          ElMessage.success('操作成功')
          data.formVisible1 = false
          load()
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

const handleAdd = () => {
  data.form = {}
  data.formVisible = true
}

const handleAdd1 = () => {
  data.form1 = { num: 1 }
  data.formVisible1 = true
}

const add = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      if (!data.form.img) {
        ElMessage.warning('请上传垃圾照片!')
        return
      }
      data.form.communityId = data.recoverySite.communityId
      data.form.siteId = data.recoverySite.id
      request.post('/garbageLaunch/add', data.form).then(res => {
        if (res.code === '200') {
          ElMessage.success('操作成功')
          data.formVisible = false
          load()
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

request.get('/recycleGarbage/selectAll').then(res => {
  data.recycleGarbageList = res.data
})

const load = () => {
  request.get('/recoverySite/selectById/' + data.id).then(res => {
    data.recoverySite = res.data
  })
}
load()
</script>

<style scoped>
.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding-bottom: 50px;
}

.site-detail-header {
  margin-bottom: 30px;
}

.breadcrumb {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  padding: 15px 20px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.back-link {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #2196F3;
  font-weight: 500;
  font-size: 15px;
  transition: all 0.3s ease;
  padding: 8px 15px;
  border-radius: 20px;
  background-color: rgba(33, 150, 243, 0.1);
}

.back-link:hover {
  background-color: rgba(33, 150, 243, 0.2);
  transform: translateX(-5px);
}

.breadcrumb-path {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}

.breadcrumb-item {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #666;
  font-size: 15px;
  padding: 5px 12px;
  border-radius: 20px;
  transition: all 0.3s ease;
}

.breadcrumb-item.current {
  background: linear-gradient(to right, rgba(76, 175, 80, 0.1), rgba(33, 150, 243, 0.1));
  color: #333;
  font-weight: 600;
}

.separator-arrow {
  margin: 0 5px;
  color: #ccc;
}

.separator-arrow .el-icon {
  font-size: 14px;
}

.site-banner {
  position: relative;
  height: 300px;
  overflow: hidden;
  border-radius: 15px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.site-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.site-banner-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100px;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
}

.site-content-container {
  display: flex;
  gap: 30px;
}

.site-sidebar {
  width: 300px;
  flex-shrink: 0;
}

.sidebar-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.sidebar-header h3 {
  font-size: 20px;
  font-weight: 600;
  margin: 0;
  color: #333;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.recycling-icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  display: flex;
  align-items: center;
  justify-content: center;
}

.recycling-icon .el-icon {
  font-size: 20px;
  color: white;
}

.recyclable-items {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.recyclable-card {
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  border: none;
}

.recyclable-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(76, 175, 80, 0.15);
}

.recyclable-img {
  height: 150px;
  overflow: hidden;
}

.recyclable-img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: all 0.5s ease;
}

.recyclable-card:hover .recyclable-img img {
  transform: scale(1.1);
}

.recyclable-info {
  padding: 15px;
}

.recyclable-name {
  font-size: 16px;
  font-weight: 600;
  margin: 0 0 10px 0;
  color: #333;
}

.recyclable-desc {
  color: #666;
  font-size: 13px;
  margin-bottom: 12px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

.recyclable-points {
  display: flex;
  align-items: center;
  gap: 5px;
  color: #FFE082;
  font-weight: 600;
  font-size: 14px;
}

.site-main-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.site-info-card, .site-content-card {
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  border: none;
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px;
  border-bottom: 1px solid #f0f0f0;
}

.site-title {
  font-size: 20px;
  font-weight: 600;
  margin: 0;
  color: #333;
}

.action-buttons {
  display: flex;
  gap: 10px;
}

.action-btn {
  border-radius: 20px;
  display: flex;
  align-items: center;
  gap: 5px;
  border: none;
  transition: all 0.3s ease;
}

.disposal-btn {
  background: linear-gradient(135deg, #4CAF50, #2196F3);
}

.disposal-btn:hover {
  background: linear-gradient(135deg, #388E3C, #1976D2);
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
}

.recycling-btn {
  background: linear-gradient(135deg, #FFE082, #FFD54F);
  color: #333;
}

.recycling-btn:hover {
  background: linear-gradient(135deg, #FFECB3, #FFD54F);
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(255, 215, 0, 0.3);
}

.site-details {
  padding: 20px;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px;
}

.detail-item {
  display: flex;
  align-items: center;
}

.detail-icon {
  color: #2196F3;
  margin-right: 8px;
  font-size: 18px;
}

.detail-label {
  color: #666;
  margin-right: 5px;
}

.detail-value {
  color: #333;
  font-weight: 500;
}

.content-header {
  padding: 20px;
  border-bottom: 1px solid #f0f0f0;
}

.content-header h3 {
  font-size: 18px;
  font-weight: 600;
  margin: 0;
  color: #333;
}

.site-content {
  padding: 20px;
  color: #666;
  line-height: 1.6;
}

.custom-dialog :deep(.el-dialog__header) {
  padding: 15px 20px;
  border-bottom: 1px solid #f0f0f0;
}

.disposal-dialog :deep(.el-dialog__header) {
  background: linear-gradient(to right, rgba(76, 175, 80, 0.05), rgba(33, 150, 243, 0.05));
}

.recycling-dialog :deep(.el-dialog__header) {
  background: linear-gradient(to right, rgba(255, 236, 179, 0.05), rgba(255, 213, 79, 0.05));
}

.custom-dialog :deep(.el-dialog__title) {
  font-weight: 600;
  font-size: 18px;
}

.custom-dialog :deep(.el-dialog) {
  border-radius: 15px;
  overflow: hidden;
}

.dialog-form {
  padding: 20px;
}

.custom-upload :deep(.el-upload-list) {
  margin-top: 15px;
}

.upload-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 20px;
  border-radius: 20px;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  color: white;
  transition: all 0.3s ease;
  cursor: pointer;
}

.upload-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(76, 175, 80, 0.2);
}

.custom-select {
  width: 100%;
}

.custom-select :deep(.el-input__wrapper),
.custom-textarea :deep(.el-textarea__wrapper) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05) !important;
  border-radius: 10px !important;
  transition: all 0.3s ease;
}

.custom-select :deep(.el-input__wrapper):hover,
.custom-textarea :deep(.el-textarea__wrapper):hover {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.1) !important;
  transform: translateY(-2px);
}

.num-input-wrapper {
  display: flex;
  align-items: center;
  gap: 10px;
}

.custom-number :deep(.el-input-number__decrease),
.custom-number :deep(.el-input-number__increase) {
  background-color: #f5f5f5;
  color: #666;
}

.unit-tag {
  padding: 5px 10px;
  background-color: #f0f0f0;
  border-radius: 5px;
  color: #666;
  font-size: 13px;
}

.score-display {
  display: flex;
  align-items: center;
  gap: 8px;
}

.score-value {
  font-size: 24px;
  font-weight: 700;
  color: #FFE082;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.score-icon {
  color: #FFD54F;
  font-size: 20px;
}

.dialog-footer {
  display: flex;
  justify-content: center;
  gap: 15px;
  padding: 10px 0;
}

.cancel-btn {
  border-radius: 20px;
  padding: 9px 20px;
}

.confirm-btn {
  border-radius: 20px;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  border: none;
  padding: 9px 20px;
  display: flex;
  align-items: center;
  gap: 5px;
  transition: all 0.3s ease;
}

.confirm-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(76, 175, 80, 0.2);
  background: linear-gradient(135deg, #388E3C, #1976D2);
}

@media (max-width: 991px) {
  .site-content-container {
    flex-direction: column;
  }
  
  .site-sidebar {
    width: 100%;
  }
  
  .site-details {
    grid-template-columns: 1fr;
  }
}
</style>