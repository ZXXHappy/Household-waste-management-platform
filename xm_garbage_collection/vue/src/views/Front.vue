<template>
  <div class="front-container">
    <div class="front-header">
      <div class="front-header-left" @click="router.push('/front/home')">
        <img src="@/assets/imgs/logo.png" alt="" class="logo-image">
        <div class="title">生活垃圾管理平台</div>
      </div>
      <div class="front-header-center">
        <el-menu :default-active="router.currentRoute.value.path" router mode="horizontal" class="nav-menu">
          <el-menu-item index="/front/home" class="nav-item">首页</el-menu-item>
          <el-menu-item index="/front/community" class="nav-item">社区垃圾投放/回收点</el-menu-item>
          <el-menu-item index="/front/scoreGoods" class="nav-item">积分兑换</el-menu-item>
          <el-menu-item index="/front/feedback" class="nav-item">反馈与建议</el-menu-item>
          <el-menu-item index="/front/notice" class="nav-item">系统公告</el-menu-item>
        </el-menu>
      </div>
      <div class="front-header-right">
        <div v-if="!data.user.id" class="auth-buttons">
          <el-button class="login-btn" @click="router.push('/login')">登录</el-button>
          <el-button class="register-btn" @click="router.push('/register')">注册</el-button>
        </div>
        <div v-else>
          <el-dropdown style="cursor: pointer; height: 60px" class="user-dropdown">
            <div class="user-info">
              <img class="avatar-image" :src="data.user.avatar" alt="">
              <span class="user-name">{{ data.user.name }}</span><el-icon><arrow-down /></el-icon>
            </div>
            <template #dropdown>
              <el-dropdown-menu class="dropdown-menu">
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
      <div class="green-wave-top"></div>
      <div class="green-wave-middle"></div>
      <transition name="slide-fade" mode="out-in">
      <RouterView @updateUser="updateUser" />
      </transition>
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
  position: relative;
  overflow-x: hidden;
  background: linear-gradient(180deg, #f8f9fa 0%, #e2f0d9 100%);
}

.logo-image {
  transition: transform 0.3s ease;
}

.logo-image:hover {
  transform: scale(1.1) rotate(5deg);
}

.nav-menu {
  display: flex;
  justify-content: center;
}

.nav-item {
  position: relative;
  overflow: hidden;
}

.nav-item::before {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  width: 0;
  height: 3px;
  background-color: #9ACD32;
  transition: all 0.3s ease;
  transform: translateX(-50%);
}

.nav-item:hover::before {
  width: 100%;
}

.auth-buttons {
  display: flex;
  gap: 10px;
}

.login-btn {
  background-color: transparent;
  color: #9ACD32;
  border: 1px solid #9ACD32;
  transition: all 0.3s ease;
}

.login-btn:hover {
  background-color: rgba(154, 205, 50, 0.1);
  transform: translateY(-2px);
}

.register-btn {
  background-color: #9ACD32;
  color: white;
  border: none;
  transition: all 0.3s ease;
}

.register-btn:hover {
  background-color: #8BB52D;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(154, 205, 50, 0.3);
}

.user-dropdown {
  transition: all 0.3s ease;
}

.user-info {
  display: flex;
  align-items: center;
  transition: all 0.3s ease;
  padding: 5px 10px;
  border-radius: 20px;
}

.user-info:hover {
  background-color: rgba(154, 205, 50, 0.1);
}

.avatar-image {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  border: 2px solid transparent;
  transition: all 0.3s ease;
}

.user-info:hover .avatar-image {
  border-color: #9ACD32;
  transform: scale(1.05);
}

.user-name {
  margin-left: 8px;
  font-weight: 500;
  transition: color 0.3s ease;
}

.user-info:hover .user-name {
  color: #9ACD32;
}

.dropdown-menu {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.el-dropdown-menu__item {
  transition: all 0.3s ease;
}

.el-dropdown-menu__item:hover {
  background-color: rgba(154, 205, 50, 0.1);
  color: #9ACD32;
}

.main-body {
  min-height: calc(100vh - 80px);
  position: relative;
  z-index: 1;
}

.green-wave-top {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 300px;
  background: linear-gradient(135deg, rgba(154, 205, 50, 0.15) 0%, rgba(85, 170, 85, 0.05) 100%);
  border-radius: 0 0 50% 50%;
  z-index: -1;
}

.green-wave-middle {
  position: absolute;
  top: 150px;
  right: -100px;
  width: 70%;
  height: 500px;
  background: linear-gradient(135deg, rgba(85, 170, 85, 0.1) 0%, rgba(154, 205, 50, 0.08) 100%);
  border-radius: 50% 0 0 50%;
  z-index: -1;
  transform: rotate(-5deg);
}
</style>