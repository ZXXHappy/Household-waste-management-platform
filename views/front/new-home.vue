<template>
  <div class="main-content">
    <el-carousel height="400px">
      <el-carousel-item v-for="item in data.typeList" :key="item.id">
        <img :src="item.img" alt="" style="width: 100%; height: 400px" @click="changeItem(item.id)">
      </el-carousel-item>
    </el-carousel>

    <div style="margin: 30px 0; ">
      <div style="width: 400px; margin: 0 auto; display: flex; justify-content: space-around">
        <div class="item" :class="{'item-active' : data.currentId === item.id }" style="padding: 10px 30px; border: 1px solid #ddd"
             v-for="item in data.typeList" :key="item.id" @click="changeType(item.id)">{{ item.name }}</div>
      </div>
    </div>

    <div style="margin-bottom: 100px">
      <el-row :gutter="20">
       <el-col :span="6" v-for="item in data.tableData" :key="item.id">
         <div class="card" style="padding: 0; cursor: pointer" @click="router.push('/front/popularizeDetail?id=' + item.id)">
           <img :src="item.img" alt="" style="width: 100%; height: 260px; border-radius: 5px 5px 0 0">
           <div style="font-size: 20px; padding: 10px" class="line1">{{ item.title }}</div>
         </div>
       </el-col>
      </el-row>

      <div style="margin: 20px 0" v-if="data.total">
        <el-pagination @current-change="loadPopularize" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
      </div>
    </div>
    
  </div>
</template>

<script setup>

</script>

<style scoped>
.item {
cursor: pointer;
}
.item-active {
  background-color: black;
  color: white;
}
</style>