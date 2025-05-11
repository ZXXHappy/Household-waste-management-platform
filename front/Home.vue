<template>
  <div class="main-content">
    <el-carousel height="400px" class="main-carousel">
      <el-carousel-item v-for="item in data.typeList" :key="item.id">
        <div class="carousel-content" @click="changeItem(item.id)">
          <img :src="item.img" alt="" class="carousel-image">
          <div class="carousel-overlay">
            <h2>{{ item.name }}</h2>
            <p>点击了解更多</p>
          </div>
        </div>
      </el-carousel-item>
    </el-carousel>

    <div class="category-container">
      <div class="category-wrapper">
        <div 
          v-for="item in data.typeList" 
          :key="item.id" 
          class="category-item"
          :class="{'category-active': data.currentId === item.id}"
          @click="changeType(item.id)"
        >
          {{ item.name }}
        </div>
      </div>
    </div>

    <div class="content-section">
      <el-row :gutter="24">
        <el-col :span="6" v-for="item in data.tableData" :key="item.id">
          <div class="content-card" @click="router.push('/front/popularizeDetail?id=' + item.id)">
            <div class="card-image-wrapper">
              <img :src="item.img" alt="" class="card-image">
            </div>
            <div class="card-content">
              <h3 class="card-title">{{ item.title }}</h3>
            </div>
          </div>
        </el-col>
      </el-row>

      <div class="pagination-container" v-if="data.total">
        <el-pagination 
          @current-change="loadPopularize" 
          background 
          layout="total, prev, pager, next" 
          :page-size="data.pageSize" 
          v-model:current-page="data.pageNum" 
          :total="data.total" 
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";
import router from "@/router/index.js";

const data = reactive({
  typeList: [],
  currentId: 0,
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
})

const changeItem = (id) => {
  data.currentId = id
  loadPopularize()
}

// 加载宣传分类和宣传列表
request.get('/popularizeType/selectAll').then(res => {
  data.typeList = res.data
  data.currentId = data.typeList?.length ? data.typeList[0].id : 0
  loadPopularize()
})

const loadPopularize = () => {
  request.get('/popularize/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      typeId: data.currentId
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

const changeType = (typeId) => {
  data.currentId = typeId
  loadPopularize()
}
</script>

<style scoped>
.main-content {
  padding: 30px;
  background-color: #f8f9fa;
  min-height: 100vh;
}

.main-carousel {
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  margin-bottom: 40px;
}

.carousel-content {
  position: relative;
  width: 100%;
  height: 100%;
  cursor: pointer;
}

.carousel-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.carousel-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 30px;
  background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
  color: white;
  transform: translateY(100%);
  transition: transform 0.3s ease;
}

.carousel-content:hover .carousel-overlay {
  transform: translateY(0);
}

.carousel-content:hover .carousel-image {
  transform: scale(1.05);
}

.carousel-overlay h2 {
  margin: 0;
  font-size: 24px;
  font-weight: 600;
}

.carousel-overlay p {
  margin: 8px 0 0;
  font-size: 16px;
  opacity: 0.9;
}

.category-container {
  margin: 40px 0;
}

.category-wrapper {
  max-width: 800px;
  margin: 0 auto;
  display: flex;
  justify-content: center;
  gap: 20px;
  flex-wrap: wrap;
}

.category-item {
  padding: 12px 30px;
  border-radius: 30px;
  background: white;
  color: #4a5568;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  border: 2px solid transparent;
}

.category-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  border-color: #65b57a;
  color: #65b57a;
}

.category-active {
  background-color: #65b57a;
  color: white;
  border-color: #65b57a;
}

.content-section {
  margin-bottom: 60px;
}

.content-card {
  background: white;
  border-radius: 16px;
  overflow: hidden;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  cursor: pointer;
  margin-bottom: 24px;
}

.content-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.card-image-wrapper {
  overflow: hidden;
  position: relative;
  padding-top: 75%;
}

.card-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.content-card:hover .card-image {
  transform: scale(1.1);
}

.card-content {
  padding: 20px;
}

.card-title {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: #2d3748;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.pagination-container {
  margin-top: 40px;
  display: flex;
  justify-content: center;
}

:deep(.el-pagination) {
  --el-pagination-button-bg-color: white;
  --el-pagination-hover-color: #65b57a;
}

:deep(.el-pagination .el-pager li) {
  border-radius: 8px;
  margin: 0 4px;
  font-weight: 500;
}

:deep(.el-pagination .el-pager li.active) {
  background-color: #65b57a;
  color: white;
}

:deep(.el-pagination .btn-prev),
:deep(.el-pagination .btn-next) {
  border-radius: 8px;
}

@media (max-width: 768px) {
  .main-content {
    padding: 15px;
  }
  
  .category-wrapper {
    gap: 10px;
  }
  
  .category-item {
    padding: 8px 20px;
    font-size: 14px;
  }
  
  .content-card {
    margin-bottom: 16px;
  }
}
</style>