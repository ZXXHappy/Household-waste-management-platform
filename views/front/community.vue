<template>
  <div style="width: 60%; margin: 10px auto">
    <div v-for="item in data.communityList" :key="item.id">
      <div @click="router.push('/front/recoverySite?communityId=' + item.id)" class="card" style="cursor: pointer; padding: 20px; display: flex; grid-gap: 20px; margin-bottom: 10px">
        <img :src="item.img" alt="" style="width: 200px; height: 150px; border-radius: 5px">
        <div style="flex: 1">
          <div style="font-size: 24px"><el-icon style="top: 5px"><OfficeBuilding /></el-icon> 名称：{{ item.name }}</div>
          <div style="margin: 10px 0; color: #666"> <el-icon style="top: 2px"><Location/></el-icon> 地址：{{ item.address }}</div>
          <div style="margin: 10px 0; color: #666"> <el-icon style="top: 2px"><User /></el-icon> 管理员：{{ item.managerName }}</div>
          <div style="margin: 10px 0; color: #666"> <el-icon style="top: 2px"><Iphone /></el-icon> 联系方式：{{ item.managerPhone }}</div>
          <div style="margin: 10px 0; color: #666"> <el-icon style="top: 2px"><MilkTea /></el-icon> 回收点数量：{{ item.recoverySiteCount }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>

</script>

<style scoped>

</style>