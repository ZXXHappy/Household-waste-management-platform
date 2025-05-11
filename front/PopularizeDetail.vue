<template>
  <div class="main-content">
    <div class="banner-container">
      <img :src="data.type.img" alt="" class="banner-image">
    </div>

    <div class="content-layout">
      <div class="sidebar">
        <div class="type-title">{{ data.type.name }}</div>
        <div class="popularize-list">
          <div 
            v-for="item in data.popularizeList" 
            :key="item.id" 
            class="popularize-item"
            @click="changeItem(item.id)"
          >
            <div class="popularize-card">
              <img :src="item.img" alt="" class="popularize-image">
              <div class="popularize-title">{{ item.title }}</div>
            </div>
          </div>
        </div>
      </div>

      <div class="main-content">
        <div class="detail-card">
          <div class="detail-layout">
            <div class="image-section">
              <img :src="data.cover" alt="" class="main-image">
              <div class="thumbnail-grid">
                <img 
                  @click="clickImg(data.popularize.thumbnail1)" 
                  :src="data.popularize.thumbnail1" 
                  alt="" 
                  class="thumbnail"
                >
                <img 
                  @click="clickImg(data.popularize.thumbnail2)" 
                  :src="data.popularize.thumbnail2" 
                  alt="" 
                  class="thumbnail"
                >
                <img 
                  @click="clickImg(data.popularize.thumbnail3)" 
                  :src="data.popularize.thumbnail3" 
                  alt="" 
                  class="thumbnail"
                >
              </div>
            </div>
            <div class="info-section">
              <h1 class="detail-title">{{ data.popularize.title }}</h1>
              <div class="view-count">
                <el-icon><View /></el-icon>
                <span>浏览量：{{ data.popularize.viewCount }}</span>
              </div>
              <div class="detail-description">{{ data.popularize.descr }}</div>
            </div>
          </div>
        </div>

        <div class="content-card">
          <div class="content-html" v-html="data.popularize.content"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";
import {View} from "@element-plus/icons-vue";

const data = reactive({
  id: router.currentRoute.value.query.id,
  popularize: {},
  type: {},
  popularizeList: [],
  cover: null
})

const changeItem = (id) => {
  data.id = id
  load()
}

const clickImg = (url) => {
  data.cover = url
}

const loadPopularize = (typeId) => {
  request.get('/popularize/selectPage', {
    params: {
      pageNum: 1,
      pageSize: 5,
      typeId: typeId
    }
  }).then(res => {
    if (res.code === '200') {
      data.popularizeList = res.data?.list || []
      console.log(data.popularizeList)
      data.popularizeList = data.popularizeList.filter(v => v.id !== parseInt(data.id))
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const load = () => {
  request.get('/popularize/selectById/' + data.id).then(res => {
    data.popularize = res.data
    data.cover = data.popularize.img
    request.get('/popularizeType/selectById/' + data.popularize.typeId).then(res => {
      data.type = res.data
    })
    loadPopularize(data.popularize.typeId)
  })
}
request.put('/popularize/updateViewCount/' + data.id).then(res => {
  load()
})
</script>

<style scoped>
.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
}

.banner-container {
  margin-bottom: 30px;
}

.banner-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  border-radius: 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

.content-layout {
  display: flex;
  gap: 24px;
}

.sidebar {
  width: 240px;
  flex-shrink: 0;
}

.type-title {
  font-size: 24px;
  font-weight: 600;
  color: #2c7a4d;
  text-align: center;
  margin-bottom: 20px;
}

.popularize-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.popularize-card {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  cursor: pointer;
}

.popularize-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.popularize-image {
  width: 100%;
  height: 150px;
  object-fit: cover;
}

.popularize-title {
  padding: 12px;
  font-size: 14px;
  color: #333;
  line-height: 1.4;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.main-content {
  flex: 1;
}

.detail-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  margin-bottom: 24px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
}

.detail-layout {
  display: flex;
  gap: 24px;
}

.image-section {
  width: 300px;
  flex-shrink: 0;
}

.main-image {
  width: 100%;
  height: 240px;
  object-fit: cover;
  border-radius: 8px;
  margin-bottom: 12px;
}

.thumbnail-grid {
  display: flex;
  gap: 8px;
}

.thumbnail {
  flex: 1;
  height: 80px;
  object-fit: cover;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.thumbnail:hover {
  transform: scale(1.05);
}

.info-section {
  flex: 1;
}

.detail-title {
  font-size: 24px;
  font-weight: 600;
  color: #333;
  margin-bottom: 16px;
}

.view-count {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #666;
  margin-bottom: 16px;
}

.detail-description {
  font-size: 16px;
  line-height: 1.8;
  color: #666;
  text-align: justify;
}

.content-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
}

.content-html {
  font-size: 16px;
  line-height: 1.8;
  color: #333;
}

.content-html :deep(img) {
  max-width: 100%;
  height: auto;
  border-radius: 8px;
  margin: 16px 0;
}

@media (max-width: 768px) {
  .main-content {
    padding: 20px;
  }
  
  .content-layout {
    flex-direction: column;
  }
  
  .sidebar {
    width: 100%;
  }
  
  .detail-layout {
    flex-direction: column;
  }
  
  .image-section {
    width: 100%;
  }
  
  .main-image {
    height: 200px;
  }
}
</style>