<template>
  <div class="main-content">
    <el-carousel height="400px" class="home-carousel">
      <el-carousel-item v-for="item in data.typeList" :key="item.id">
        <div class="carousel-overlay"></div>
        <img :src="item.img" alt="" class="carousel-image" @click="changeItem(item.id)">
        <div class="carousel-caption">
          <h3>{{ item.name }}</h3>
        </div>
      </el-carousel-item>
    </el-carousel>

    <div class="type-selection">
      <div class="type-container">
        <div class="type-item" :class="{'type-item-active' : data.currentId === item.id }"
             v-for="item in data.typeList" :key="item.id" @click="changeType(item.id)">{{ item.name }}</div>
      </div>
    </div>

    <div class="content-section-title">
      <div class="section-line"></div>
      <h2>精选内容</h2>
      <div class="section-line"></div>
    </div>

    <div class="content-cards">
      <el-row :gutter="30">
       <el-col :span="6" v-for="item in data.tableData" :key="item.id">
         <div class="card content-card gradient-card" @click="router.push('/front/popularizeDetail?id=' + item.id)">
           <div class="card-badge">推荐</div>
           <div class="img-container">
             <img :src="item.img" alt="" class="card-image">
           </div>
           <div class="card-content">
             <div class="card-title">{{ item.title }}</div>
             <div class="card-footer">
               <div class="card-date">{{ formatDate(item.createTime) }}</div>
               <div class="card-actions">
                 <i class="el-icon-view"></i>
               </div>
             </div>
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
          :total="data.total" />
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

const formatDate = (dateStr) => {
  if (!dateStr) return '';
  const date = new Date(dateStr);
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
}
</script>

<style scoped>
.home-carousel {
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
  margin-bottom: 40px;
}

.carousel-image {
  width: 100%; 
  height: 400px;
  object-fit: cover;
  transition: transform 0.8s ease;
cursor: pointer;
}

.carousel-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to bottom, transparent 60%, rgba(0, 0, 0, 0.6));
  z-index: 1;
}

.carousel-caption {
  position: absolute;
  bottom: 30px;
  left: 40px;
  z-index: 2;
}

.carousel-caption h3 {
  color: #fff;
  font-size: 32px;
  font-weight: 700;
  margin: 0;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
  transition: transform 0.3s ease;
}

.el-carousel__item:hover .carousel-caption h3 {
  transform: translateY(-5px);
}

.el-carousel:hover .carousel-image {
  transform: scale(1.05);
}

.type-selection {
  margin: 30px 0 40px;
}

.type-container {
  width: 500px; 
  margin: 0 auto; 
  display: flex; 
  justify-content: space-around;
  padding: 5px;
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 25px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.type-item {
  padding: 10px 25px; 
  border: 1px solid transparent;
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
  z-index: 1;
  font-weight: 500;
}

.type-item:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.2);
  border-color: #4CAF50;
}

.type-item::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(76, 175, 80, 0.7), rgba(33, 150, 243, 0.7));
  opacity: 0;
  z-index: -1;
  transition: opacity 0.3s ease;
}

.type-item:hover::before {
  opacity: 0.1;
}

.type-item-active {
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  color: white;
  border-color: transparent;
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
}

.type-item-active::before {
  opacity: 0;
}

.content-section-title {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 30px;
}

.content-section-title h2 {
  margin: 0 15px;
  font-size: 24px;
  font-weight: 700;
  color: #333;
  position: relative;
}

.section-line {
  height: 2px;
  width: 80px;
  background: linear-gradient(to right, #4CAF50, #2196F3);
}

.content-cards {
  margin-bottom: 100px;
}

.content-card {
  padding: 0;
  cursor: pointer;
  height: 100%;
  border-radius: 20px !important;
  margin-bottom: 30px;
  overflow: visible;
  position: relative;
}

.img-container {
  overflow: hidden;
  height: 200px;
  border-radius: 20px 20px 0 0;
  position: relative;
}

.card-badge {
  position: absolute;
  top: 15px;
  right: 15px;
  background: linear-gradient(135deg, #FFD700, #F5CB00);
  color: #fff;
  padding: 5px 12px;
  border-radius: 15px;
  font-size: 12px;
  font-weight: 600;
  z-index: 2;
  box-shadow: 0 2px 8px rgba(255, 215, 0, 0.3);
  transition: all 0.3s ease;
}

.content-card:hover .card-badge {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(255, 215, 0, 0.4);
}

.card-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: all 0.5s ease;
}

.content-card:hover .card-image {
  transform: scale(1.1);
}

.card-content {
  padding: 20px;
}

.card-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
  transition: color 0.3s ease;
  margin-bottom: 15px;
  line-height: 1.4;
  height: 50px;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.content-card:hover .card-title {
  color: #4CAF50;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 10px;
  border-top: 1px solid #eee;
}

.card-date {
  font-size: 12px;
  color: #888;
}

.card-actions {
  display: flex;
  align-items: center;
}

.pagination-container {
  margin-top: 40px;
  text-align: center;
}
</style>