<template>
  <div style="width: 60%; margin: 10px auto">
    <div style="margin: 10px 0 20px 0; font-size: 24px; font-weight: bold">{{ data.community.name }} 垃圾投放/回收点</div>
    <el-row :gutter="10">
      <el-col :span="12" v-for="item in data.tableData" :key="item.id">
        <div @click="router.push('/front/recoverySiteDetail?id=' + item.id)" class="card" style="cursor: pointer; padding: 20px; display: flex; grid-gap: 20px; margin-bottom: 10px">
          <img :src="item.img" alt="" style="width: 200px; height: 150px; border-radius: 5px">
          <div style="flex: 1; width: 0">
            <div style="font-size: 24px" class="line1"><el-icon style="top: 5px"><Place /></el-icon> {{ item.name }}</div>
            <div style="margin: 10px 0; color: #666"> <el-icon style="top: 2px"><User /></el-icon> {{ item.managerName }}</div>
            <div style="margin: 10px 0; color: #666"> <el-icon style="top: 2px"><Iphone /></el-icon> {{ item.managerPhone }}</div>
            <div style="margin: 10px 0; color: #666"> <el-icon style="top: 2px"><Clock /></el-icon> {{ item.timeRange }}</div>
            <div style="margin: 10px 0; color: #666"> <el-icon style="top: 2px"><Open /></el-icon>
              <span style="margin-left: 5px">
              <el-tag size="small" type="success" v-if="item.status === '运行中'">运行中</el-tag>
              <el-tag ize="small" type="danger" v-if="item.status === '已关闭'">已关闭</el-tag>
            </span>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  communityId: router.currentRoute.value.query.communityId,
  tableData: [],
  community: {}
})

request.get('/community/selectById/' + data.communityId).then(res => {
  data.community = res.data
})

const load = () => {
  request.get('/recoverySite/selectAll', {
    params: {
      communityId: data.communityId
    }
  }).then(res => {
    if (res.code === '200') {
      data.tableData = res.data || []
    } else {
      ElMessage.error(res.msg)
    }
  })
}
load()
</script>

<style>

</style>