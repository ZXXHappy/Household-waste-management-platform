<template>
  <RouterView />
</template>

<style>
/* 全局过渡动画 */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* 页面切换动画 */
.slide-fade-enter-active {
  transition: all 0.3s ease-out;
}
.slide-fade-leave-active {
  transition: all 0.3s cubic-bezier(1, 0.5, 0.8, 1);
}
.slide-fade-enter-from,
.slide-fade-leave-to {
  transform: translateY(20px);
  opacity: 0;
}

/* 全局悬浮效果 */
.hover-grow {
  transition: transform 0.3s ease;
}
.hover-grow:hover {
  transform: scale(1.05);
}

.hover-shadow {
  transition: box-shadow 0.3s ease, transform 0.3s ease;
}
.hover-shadow:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

/* 全局波纹效果 */
.ripple {
  position: relative;
  overflow: hidden;
}
.ripple:after {
  content: "";
  background: rgba(255, 255, 255, 0.3);
  display: block;
  position: absolute;
  border-radius: 50%;
  width: 100px;
  height: 100px;
  top: 50%;
  left: 50%;
  pointer-events: none;
  transform: translate(-50%, -50%) scale(0);
  opacity: 1;
  transition: transform 0.5s, opacity 0.5s;
}
.ripple:active:after {
  transform: translate(-50%, -50%) scale(3);
  opacity: 0;
  transition: 0s;
}

/* 统一颜色变量 */
:root {
  --primary-color: #4CAF50;
  --primary-dark: #388E3C;
  --primary-light: rgba(76, 175, 80, 0.1);
  --primary-bg: #E8F5E9;
  --accent-color: #FFD700;
  --accent-dark: #F5CB00;
  --accent-light: rgba(255, 215, 0, 0.1);
  --blue-color: #2196F3;
  --blue-dark: #1976D2;
  --blue-light: rgba(33, 150, 243, 0.1);
  --text-primary: #333333;
  --text-secondary: #666666;
  --background-light: #f8f9fa;
}

/* 添加平滑滚动 */
html {
  scroll-behavior: smooth;
}

/* 全局圆角 */
button, 
.el-button, 
.el-input__wrapper, 
.el-textarea__wrapper, 
.el-input-number, 
.el-select,
.el-select-dropdown,
.el-menu,
.el-dropdown-menu,
.el-dialog,
.el-message,
.el-card,
.card {
  border-radius: 12px !important;
  overflow: hidden;
}

/* 全局绿色背景 */
body {
  background-color: var(--primary-bg);
}

/* 基础元素动画 */
button, a {
  transition: all 0.3s ease;
}

/* 全局链接样式 */
a {
  color: var(--primary-color);
  text-decoration: none;
  font-weight: 500;
}
a:hover {
  color: var(--blue-color);
}

/* 自定义滚动条 */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

::-webkit-scrollbar-thumb {
  background: var(--primary-color);
  border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
  background: var(--primary-dark);
}

/* El-Button 样式覆盖 */
.el-button {
  font-weight: 500 !important;
  border-radius: 12px !important;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* 表单输入框样式 */
.el-input__wrapper,
.el-textarea__wrapper {
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05) !important;
  transition: all 0.3s ease !important;
}

.el-input__wrapper:hover,
.el-textarea__wrapper:hover {
  box-shadow: 0 4px 10px rgba(76, 175, 80, 0.15) !important;
}

.el-input__wrapper:focus-within,
.el-textarea__wrapper:focus-within {
  box-shadow: 0 4px 10px rgba(76, 175, 80, 0.2) !important;
  transform: translateY(-2px);
}
</style>