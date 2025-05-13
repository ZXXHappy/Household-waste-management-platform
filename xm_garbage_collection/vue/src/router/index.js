import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', redirect: '/manager/home' },
    {
      path: '/manager',
      component: () => import('@/views/Manager.vue'),
      children: [
        { path: 'home', meta: { name: '系统首页' }, component: () => import('@/views/manager/Home.vue'),  },
        { path: 'admin', meta: { name: '管理员信息' }, component: () => import('@/views/manager/Admin.vue'), },
        { path: 'notice', meta: { name: '系统公告' }, component: () => import('@/views/manager/Notice.vue'), },
        { path: 'person', meta: { name: '个人资料' }, component: () => import('@/views/manager/Person.vue'), },
        { path: 'password', meta: { name: '修改密码' }, component: () => import('@/views/manager/Password.vue'), },
        { path: 'user', meta: { name: '普通用户信息' }, component: () => import('@/views/manager/User.vue'), },
        { path: 'communityAdmin', meta: { name: '社区管理员信息' }, component: () => import('@/views/manager/CommunityAdmin.vue'), },
        { path: 'popularizeType', meta: { name: '宣传分类信息' }, component: () => import('@/views/manager/PopularizeType.vue'), },
        { path: 'popularize', meta: { name: '宣传信息' }, component: () => import('@/views/manager/Popularize.vue'), },
        { path: 'community', meta: { name: '社区信息' }, component: () => import('@/views/manager/Community.vue'), },
        { path: 'recycleGarbage', meta: { name: '可回收垃圾信息' }, component: () => import('@/views/manager/RecycleGarbage.vue'), },
        { path: 'recoverySite', meta: { name: '垃圾投放/回收点信息' }, component: () => import('@/views/manager/RecoverySite.vue'), },
        { path: 'garbageLaunch', meta: { name: '垃圾投放记录' }, component: () => import('@/views/manager/GarbageLaunch.vue'), },
        { path: 'recoveryRecords', meta: { name: '垃圾回收记录' }, component: () => import('@/views/manager/RecoveryRecords.vue'), },
        { path: 'scoreGoods', meta: { name: '积分物品信息' }, component: () => import('@/views/manager/ScoreGoods.vue'), },
        { path: 'scoreExchange', meta: { name: '积分兑换记录' }, component: () => import('@/views/manager/ScoreExchange.vue'), },
        { path: 'feedback', meta: { name: '用户反馈信息' }, component: () => import('@/views/manager/Feedback.vue'), },
        { path: 'statistics', meta: { name: '数据统计' }, component: () => import('@/views/manager/Statistics.vue'), },
      ]
    },
    {
      path: '/front',
      component: () => import('@/views/Front.vue'),
      children: [
        { path: 'home', component: () => import('@/views/front/Home.vue'),  },
        { path: 'person', component: () => import('@/views/front/Person.vue'),  },
        { path: 'popularizeDetail', component: () => import('@/views/front/PopularizeDetail.vue'),  },
        { path: 'community', component: () => import('@/views/front/Community.vue'),  },
        { path: 'recoverySite', component: () => import('@/views/front/RecoverySite.vue'),  },
        { path: 'recoverySiteDetail', component: () => import('@/views/front/RecoverySiteDetail.vue'),  },
        { path: 'myGarbageLaunch', component: () => import('@/views/front/MyGarbageLaunch.vue'),  },
        { path: 'notice', component: () => import('@/views/front/Notice.vue'),  },
        { path: 'scoreGoods', component: () => import('@/views/front/ScoreGoods.vue'),  },
        { path: 'password', component: () => import('@/views/front/Password.vue'),  },
        { path: 'myScoreExchange', component: () => import('@/views/front/MyScoreExchange.vue'),  },
        { path: 'myRecoveryRecords', component: () => import('@/views/front/MyRecoveryRecords.vue'),  },
        { path: 'feedback', component: () => import('@/views/front/Feedback.vue'),  },
        { path: 'myFeedback', component: () => import('@/views/front/MyFeedback.vue'),  },
      ]
    },
    { path: '/login', component: () => import('@/views/Login.vue') },
    { path: '/register', component: () => import('@/views/Register.vue') },
    { path: '/404', component: () => import('@/views/404.vue') },
    { path: '/:pathMatch(.*)', redirect: '/404' }
  ]
})

export default router
