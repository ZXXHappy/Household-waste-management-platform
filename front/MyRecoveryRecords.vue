<template>
  <div class="main-content">
    <div class="recovery-records-header">
      <h2 class="section-title">我的垃圾回收记录</h2>
      <div class="title-underline"></div>
      <p class="section-description">查看您的环保历程和积分获取记录</p>
    </div>
    
    <div class="card records-card">
      <div class="search-area">
        <div class="search-wrapper">
          <el-input v-model="data.siteName" placeholder="请输入社区垃圾投放点名称查询" class="search-input">
            <template #prefix>
              <el-icon class="search-icon"><Search /></el-icon>
            </template>
          </el-input>
          <el-button type="primary" plain @click="load" class="search-btn">
            <el-icon><Search /></el-icon>
            查询
          </el-button>
          <el-button type="warning" plain @click="reset" class="reset-btn">
            <el-icon><RefreshRight /></el-icon>
            重置
          </el-button>
        </div>
      </div>

      <div class="records-table-wrapper">
        <el-table 
          :data="data.tableData" 
          @selection-change="handleSelectionChange"
          class="custom-table"
          :header-cell-style="{
            background: 'linear-gradient(to right, rgba(76, 175, 80, 0.05), rgba(33, 150, 243, 0.05))',
            color: '#333',
            fontWeight: '600',
            padding: '12px 0'
          }"
          :row-class-name="tableRowClassName"
        >
          <el-table-column prop="garbageName" label="可回收垃圾类型"></el-table-column>
          <el-table-column prop="img" label="可回收垃圾照片">
            <template #default="scope">
              <div class="image-preview">
                <el-image 
                  :src="scope.row.img" 
                  :preview-src-list="[scope.row.img]" 
                  preview-teleported
                  fit="cover"
                  class="garbage-image"
                ></el-image>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="communityName" label="社区"></el-table-column>
          <el-table-column prop="siteName" label="回收点"></el-table-column>
          <el-table-column prop="num" label="回收数量"></el-table-column>
          <el-table-column prop="score" label="总计积分">
            <template #default="scope">
              <div class="score-cell">
                <el-icon><GoldMedal /></el-icon>
                <span>{{ scope.row.score }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="time" label="申请时间"></el-table-column>
          <el-table-column prop="remark" label="备注" :show-overflow-tooltip="true"></el-table-column>
          <el-table-column prop="status" label="回收状态">
            <template #default="scope">
              <el-tag 
                :type="scope.row.status === '待审核' ? 'warning' : scope.row.status === '通过' ? 'success' : 'danger'" 
                effect="light"
                class="status-tag"
              >
                {{ scope.row.status }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="rejectReason" label="拒绝备注" :show-overflow-tooltip="true"></el-table-column>
        </el-table>
      </div>
      
      <div v-if="data.total" class="pagination-area">
        <el-pagination 
          @current-change="load" 
          background 
          layout="total, prev, pager, next" 
          :page-size="data.pageSize" 
          v-model:current-page="data.pageNum" 
          :total="data.total" 
          class="custom-pagination"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import {reactive} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";
import { Search, RefreshRight, GoldMedal } from '@element-plus/icons-vue';

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  formVisible: false,
  form: {},
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
  siteName: null,
  ids: []
})

const tableRowClassName = ({ row }) => {
  if (row.status === '通过') {
    return 'success-row'
  } else if (row.status === '拒绝') {
    return 'error-row'
  }
  return ''
}

const baseUrl = import.meta.env.VITE_BASE_URL
const handleFileUpload = (res) => {
  data.form.img = res.data
}

const load = () => {
  request.get('/recoveryRecords/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      siteName: data.siteName
    }
  }).then(res => {
    if (res.code === '200') {
      data.tableData = res.data?.list || []
      data.total = res.data?.total
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const handleSelectionChange = (rows) => {
  data.ids = rows.map(v => v.id)
}

const reset = () => {
  data.siteName = null
  load()
}

load()
</script>

<style scoped>
.recovery-records-header {
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

.records-card {
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
  border: none;
  margin-bottom: 40px;
}

.search-area {
  padding: 20px;
  border-bottom: 1px solid #f0f0f0;
}

.search-wrapper {
  display: flex;
  align-items: center;
  gap: 15px;
}

.search-input {
  width: 350px;
  transition: all 0.3s ease;
}

.search-input :deep(.el-input__wrapper) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05) !important;
  border-radius: 10px !important;
  transition: all 0.3s ease;
}

.search-input :deep(.el-input__wrapper):hover {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.15) !important;
  transform: translateY(-2px);
}

.search-icon {
  color: #4CAF50;
}

.search-btn, .reset-btn {
  border-radius: 10px;
  display: flex;
  align-items: center;
  gap: 5px;
  transition: all 0.3s ease;
}

.search-btn {
  border-color: #4CAF50;
  color: #4CAF50;
}

.search-btn:hover {
  background-color: #4CAF50;
  color: white;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2);
}

.reset-btn {
  border-color: #FFE082;
  color: #FFE082;
}

.reset-btn:hover {
  background-color: #FFE082;
  color: white;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(255, 213, 79, 0.2);
}

.records-table-wrapper {
  padding: 0 20px;
}

.custom-table {
  margin: 15px 0;
  border-radius: 10px;
  overflow: hidden;
}

.custom-table :deep(.el-table__row) {
  transition: all 0.3s ease;
}

.custom-table :deep(.el-table__row:hover) {
  background-color: rgba(76, 175, 80, 0.05) !important;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
}

.custom-table :deep(.success-row) {
  background-color: rgba(76, 175, 80, 0.05);
}

.custom-table :deep(.error-row) {
  background-color: rgba(244, 67, 54, 0.05);
}

.image-preview {
  width: 100px;
  height: 80px;
  overflow: hidden;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.image-preview:hover {
  transform: scale(1.05);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
}

.garbage-image {
  width: 100%;
  height: 100%;
  transition: all 0.5s ease;
}

.score-cell {
  display: flex;
  align-items: center;
  gap: 5px;
  color: #FFE082;
  font-weight: 600;
}

.status-tag {
  border-radius: 20px;
  padding: 2px 10px;
  font-weight: 600;
}

.pagination-area {
  padding: 20px;
  border-top: 1px solid #f0f0f0;
  display: flex;
  justify-content: center;
}

.custom-pagination :deep(.el-pagination.is-background .el-pager li:not(.is-disabled).is-active) {
  background: linear-gradient(135deg, #4CAF50, #2196F3);
}
</style>