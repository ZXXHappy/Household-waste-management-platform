<template>
  <div class="front-container">
    <div class="front-header">
      <div class="front-header-left" @click="router.push('/front/home')">
        <img src="@/assets/imgs/logo.png" alt="">
        <div class="title">生活垃圾管理平台</div>
      </div>
      <div class="front-header-center">
        <el-menu :default-active="router.currentRoute.value.path" router mode="horizontal">
          <el-menu-item index="/front/home">首页</el-menu-item>
          <el-menu-item index="/front/community">社区垃圾投放/回收点</el-menu-item>
          <el-menu-item index="/front/scoreGoods">积分兑换</el-menu-item>
          <el-menu-item index="/front/feedback">反馈与建议</el-menu-item>
          <el-menu-item index="/front/notice">系统公告</el-menu-item>
        </el-menu>
      </div>
      <div class="front-header-right">
        <div v-if="!data.user.id">
          <el-button @click="router.push('/login')">登录</el-button>
          <el-button @click="router.push('/register')">注册</el-button>
        </div>
        <div v-else>
          <el-dropdown style="cursor: pointer; height: 60px">
            <div style="display: flex; align-items: center">
              <img style="width: 40px; height: 40px; border-radius: 50%;" :src="data.user.avatar" alt="">
              <span style="margin-left: 5px;">{{ data.user.name }}</span><el-icon><arrow-down /></el-icon>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="router.push('/front/myScoreExchange')">积分兑换记录</el-dropdown-item>
                <el-dropdown-item @click="router.push('/front/myGarbageLaunch')">垃圾投放记录</el-dropdown-item>
                <el-dropdown-item @click="router.push('/front/myRecoveryRecords')">垃圾回收记录</el-dropdown-item>
                <el-dropdown-item @click="router.push('/front/myFeedback')">我的反馈</el-dropdown-item>
                <el-dropdown-item @click="router.push('/front/person')">个人信息</el-dropdown-item>
                <el-dropdown-item @click="router.push('/front/password')">修改密码</el-dropdown-item>
                <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </div>
    <div class="main-body">
      <RouterView @updateUser="updateUser" />
    </div>
  </div>
</template>

<script setup>
  import router from "@/router/index.js";
  import { reactive } from "vue";
  import request from "@/utils/request.js";

  const data = reactive({
    user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
    top: '',
    noticeData: []
  })

  const logout = () => {
    localStorage.removeItem('xm-user')
    router.push('/login')
  }

  const updateUser = () => {
    data.user =  JSON.parse(localStorage.getItem('xm-user') || '{}')
  }

</script>

<style scoped>
@import "@/assets/css/front.css";

.front-container {
  min-height: 100vh;
  background-color: #f2f7f4;
}

.main-body {
  padding: 15px;
}
</style>