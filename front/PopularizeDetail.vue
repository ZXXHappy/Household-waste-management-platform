<template>
  <div style="width: 60%; margin: 10px auto 50px auto;">
    <div style="margin-bottom: 20px">
      <img :src="data.type.img" alt="" style="width: 100%; height: 400px">
    </div>

    <div style="display: flex; grid-gap: 20px">
      <div style="width: 200px">
        <div style="font-size: 24px; font-weight: bold; text-align: center">{{ data.type.name }}</div>
        <div style="margin: 20px 0">
          <div v-for="item in data.popularizeList" :key="item.id" style="margin-bottom: 10px">
            <div class="card" style="cursor: pointer" @click="changeItem(item.id)">
              <img :src="item.img" alt="" style="width: 100%; height: 150px">
              <div style="margin-top: 5px" class="line1">{{ item.title }}</div>
            </div>
          </div>
        </div>
      </div>

      <div style="flex: 1">
        <div class="card" style="padding: 20px; margin-bottom: 10px">
          <div style="display: flex; grid-gap: 20px">
            <div style="width: 300px">
              <img :src="data.cover" alt="" style="width: 100%; height: 240px; margin-bottom: 10px">
              <div style="display: flex; grid-gap: 10px; width: 100%">
                <img @click="clickImg(data.popularize.thumbnail1)" :src="data.popularize.thumbnail1" alt="" style="flex: 1; width: 0">
                <img @click="clickImg(data.popularize.thumbnail2)" :src="data.popularize.thumbnail2" alt="" style="flex: 1; width: 0">
                <img @click="clickImg(data.popularize.thumbnail3)" :src="data.popularize.thumbnail3" alt="" style="flex: 1; width: 0">
              </div>
            </div>
            <div style="flex: 1">
              <div style="font-size: 24px; margin-bottom: 10px">{{ data.popularize.title }}</div>
              <div style="margin: 10px 0; font-size: 16px; color: #666">
                <span>浏览量：{{ data.popularize.viewCount }}</span>
              </div>
              <div style="font-size: 18px; text-align: justify; line-height: 30px; color: #666">{{data.popularize.descr }}</div>
            </div>
          </div>
        </div>

        <div class="card" style="padding: 20px">
          <div v-html="data.popularize.content"></div>
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

</style>