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

</script>

<style scoped>

</style>