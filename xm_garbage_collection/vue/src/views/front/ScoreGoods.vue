<template>
  <div class="main-content">
    <div class="score-goods-header">
      <h2 class="section-title">积分兑换商城</h2>
      <div class="title-underline"></div>
      <p class="section-description">用您的环保积分兑换丰富好礼</p>
    </div>

    <div class="search-container">
      <el-input size="large" v-model="data.name" placeholder="请输入物品名称查询" class="search-input">
        <template #prefix>
          <el-icon class="search-icon"><Search /></el-icon>
        </template>
      </el-input>
      <el-button size="large" type="primary" @click="load" class="btn-search">
        <el-icon><Search /></el-icon>
        <span>查询</span>
      </el-button>
      <el-button size="large" type="warning" @click="reset" class="btn-reset">
        <el-icon><RefreshRight /></el-icon>
        <span>重置</span>
      </el-button>
    </div>

    <div class="goods-container">
      <el-row :gutter="30">
        <el-col :xs="24" :sm="12" :md="8" v-for="item in data.tableData" :key="item.id">
          <div class="card score-card">
            <div class="img-wrapper">
              <div class="img-container">
                <img :src="item.img" alt="" class="goods-image">
              </div>
              <div class="price-tag">
                <span class="score-number">{{item.score}}</span>
                <span class="score-unit">积分/{{item.unit }}</span>
              </div>
              <div class="ribbon" v-if="item.num <= 5">
                <span>剩余有限</span>
              </div>
            </div>
            <div class="goods-info">
              <div class="goods-title">{{ item.name }}</div>
              <div class="goods-desc">{{ item.descr }}</div>
              <div class="goods-footer">
                <div class="goods-stock">
                  <el-icon class="stock-icon"><Goods /></el-icon>
                  <span>剩余：{{ item.num }} {{item.unit}}</span>
                </div>
                <el-button type="primary" class="btn-exchange" @click="handleExchange(item)">
                  <el-icon><ShoppingCart /></el-icon>
                  立即兑换
                </el-button>
             </div>
           </div>
         </div>
       </el-col>
      </el-row>
    </div>

    <div v-if="data.total" class="pagination">
      <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
    </div>

    <el-dialog title="积分兑换" v-model="data.formVisible" width="40%" destroy-on-close class="exchange-dialog">
      <div class="dialog-goods-preview">
        <div class="preview-image">
          <img :src="data.goods.img" alt="">
        </div>
        <div class="preview-info">
          <h3>{{ data.goods.name }}</h3>
          <p>{{ data.goods.descr }}</p>
        </div>
      </div>
      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="110px" class="exchange-form">
        <el-form-item prop="num" label="兑换数量">
          <el-input-number @click="calScore" style="width: 200px" :min="1" :max="data.goods.num" v-model="data.form.num" placeholder="请输入兑换数量"></el-input-number>
        </el-form-item>
        <el-form-item prop="score" label="消耗积分">
          <b class="score-text">{{ data.form.score }}</b>
        </el-form-item>
        <el-form-item prop="receiveName" label="接收人名称">
          <el-input v-model="data.form.receiveName" placeholder="请输入接收人名称" class="form-input"></el-input>
        </el-form-item>
        <el-form-item prop="receivePhone" label="接收人电话">
          <el-input v-model="data.form.receivePhone" placeholder="请输入接收人电话" class="form-input"></el-input>
        </el-form-item>
        <el-form-item prop="receiveAddress" label="接收人地址">
          <el-input type="textarea" :rows="3" v-model="data.form.receiveAddress" placeholder="请输入接收人地址" class="form-input"></el-input>
        </el-form-item>
        <div class="score-balance">
          <el-icon><Trophy /></el-icon>
          <span>我的积分余额：</span>
          <b class="user-score">{{ data.userScore }}</b>
          <div class="score-status" :class="data.form.score > data.userScore ? 'insufficient' : 'sufficient'">
            {{ data.form.score > data.userScore ? '积分不足' : '积分充足' }}
          </div>
        </div>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false" class="cancel-btn">取 消</el-button>
          <el-button type="primary" @click="exchange" :disabled="data.form.score > data.userScore" class="confirm-btn">
            <el-icon><ShoppingCartFull /></el-icon>
            确认兑换
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import {reactive, ref} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";
import {
  Search, RefreshRight, Goods, ShoppingCart, 
  ShoppingCartFull, Trophy
} from '@element-plus/icons-vue';

const formRef = ref()

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  formVisible: false,
  form: {},
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
  name: null,
  ids: [],
  goods: {},
  userScore: 0,
  rules: {
    receiveName: [
      { required: true, message: '请输入接收人名称', trigger: 'blur' }
    ],
    receivePhone: [
      { required: true, message: '请输入接收人电话', trigger: 'blur' }
    ],
    receiveAddress: [
      { required: true, message: '请输入接收人地址', trigger: 'blur' }
    ]
  }
})

request.get('/user/selectById/' + data.user.id).then(res => {
  data.userScore = res.data.score
})

const calScore = () => {
  data.form.score = data.goods.score * data.form.num
}

const handleExchange = (goods) => {
  data.goods = goods
  data.form = { num: 1, goodsId: goods.id }
  calScore()
  data.formVisible = true
}

const exchange = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      request.post('/scoreExchange/add', data.form).then(res => {
        if (res.code === '200') {
          ElMessage.success('操作成功')
          data.formVisible = false
          load()
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

const baseUrl = import.meta.env.VITE_BASE_URL
const handleFileUpload = (res) => {
  data.form.img = res.data
}

const load = () => {
  request.get('/scoreGoods/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name
    }
  }).then(res => {
    if (res.code === '200') {
      data.tableData = res.data?.list || []
      data.total = res.data?.total
    } else {
      ElMessage.error(res.msg)
    }
  })
}
const handleAdd = () => {
  data.form = { num: 1, score: 1 }
  data.formVisible = true
}
const handleEdit = (row) => {
  data.form = JSON.parse(JSON.stringify(row))
  data.formVisible = true
}
const add = () => {
  request.post('/scoreGoods/add', data.form).then(res => {
    if (res.code === '200') {
      ElMessage.success('操作成功')
      data.formVisible = false
      load()
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const update = () => {
  request.put('/scoreGoods/update', data.form).then(res => {
    if (res.code === '200') {
      ElMessage.success('操作成功')
      data.formVisible = false
      load()
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const save = () => {
  data.form.id ? update() : add()
}

const del = (id) => {
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { type: 'warning' }).then(res => {
    request.delete('/scoreGoods/delete/' + id).then(res => {
      if (res.code === '200') {
        ElMessage.success("删除成功")
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(err => {
    console.error(err)
  })
}
const delBatch = () => {
  if (!data.ids.length) {
    ElMessage.warning("请选择数据")
    return
  }
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { type: 'warning' }).then(res => {
    request.delete("/scoreGoods/delete/batch", {data: data.ids}).then(res => {
      if (res.code === '200') {
        ElMessage.success('操作成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(err => {
    console.error(err)
  })
}
const handleSelectionChange = (rows) => {
  data.ids = rows.map(v => v.id)
}

const reset = () => {
  data.name = null
  load()
}

load()
</script>

<style scoped>
.score-goods-header {
  text-align: center;
  margin-bottom: 30px;
}

.section-title {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  margin-bottom: 10px;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.title-underline {
  width: 100px;
  height: 4px;
  background: linear-gradient(to right, #4CAF50, #2196F3);
  margin: 0 auto 15px;
  border-radius: 2px;
}

.section-description {
  color: #666;
  font-size: 16px;
  margin-bottom: 30px;
}

.search-container {
  margin-bottom: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 15px;
}

.search-input {
  width: 400px;
  transition: all 0.3s ease;
  border-radius: 50px;
  overflow: hidden;
}

.search-input :deep(.el-input__wrapper) {
  border-radius: 50px;
  padding-left: 20px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.search-input:hover :deep(.el-input__wrapper) {
  box-shadow: 0 6px 20px rgba(76, 175, 80, 0.15);
  transform: translateY(-2px);
}

.search-icon {
  color: #4CAF50;
  font-size: 18px;
}

.btn-search, .btn-reset {
  border-radius: 50px;
  padding: 0 25px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 8px;
  border: none;
}

.btn-search {
  background: linear-gradient(135deg, #4CAF50, #2196F3);
}

.btn-search:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(76, 175, 80, 0.2);
  background: linear-gradient(135deg, #388E3C, #1976D2);
}

.btn-reset {
  background: linear-gradient(135deg, #FFE082, #FFD54F);
  color: #333;
}

.btn-reset:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(255, 215, 0, 0.2);
  background: linear-gradient(135deg, #FFECB3, #FFD54F);
}

.goods-container {
  margin-bottom: 40px;
}

.score-card {
  margin-bottom: 30px;
  height: 100%;
  display: flex;
  flex-direction: column;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  position: relative;
  border: none;
  background-color: white;
}

.score-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(76, 175, 80, 0.15);
}

.img-wrapper {
  position: relative;
}

.img-container {
  overflow: hidden;
  height: 0;
  padding-bottom: 75%; /* 4:3 Aspect Ratio */
  position: relative;
}

.goods-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  transition: all 0.5s ease;
  object-fit: cover;
}

.score-card:hover .goods-image {
  transform: scale(1.1);
}

.price-tag {
  position: absolute;
  top: 15px;
  right: 15px;
  background: linear-gradient(135deg, rgba(255, 236, 179, 0.9), rgba(255, 213, 79, 0.9));
  padding: 10px 15px;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  align-items: center;
  z-index: 2;
  backdrop-filter: blur(5px);
  border: 2px solid rgba(255, 255, 255, 0.5);
}

.price-tag .score-number {
  color: #333;
  font-weight: bold;
  font-size: 22px;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  line-height: 1;
}

.price-tag .score-unit {
  font-size: 10px;
  color: #333;
  margin-top: 2px;
}

.ribbon {
  position: absolute;
  top: 15px;
  left: -30px;
  background: #FF6B6B;
  color: white;
  font-size: 12px;
  font-weight: 600;
  padding: 5px 30px;
  transform: rotate(-45deg);
  z-index: 1;
}

.goods-info {
  padding: 15px;
  display: flex;
  flex-direction: column;
  flex-grow: 1;
}

.goods-title {
  font-size: 18px;
  font-weight: 700;
  color: #333;
  transition: color 0.3s ease;
  margin-bottom: 8px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.score-card:hover .goods-title {
  color: #4CAF50;
}

.goods-desc {
  margin-bottom: 15px;
  color: #666;
  height: 40px;
  line-height: 20px;
  text-align: justify;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  font-size: 14px;
}

.goods-footer {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-top: auto;
}

.goods-stock {
  display: flex;
  align-items: center;
  padding: 5px 10px;
  background-color: rgba(33, 150, 243, 0.05);
  border-radius: 20px;
  width: fit-content;
  font-size: 13px;
}

.stock-icon {
  color: #2196F3;
  margin-right: 5px;
}

.btn-exchange {
  padding: 8px 0;
  border-radius: 20px;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  border: none;
  transition: all 0.3s ease;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  width: 100%;
}

.btn-exchange:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
  background: linear-gradient(135deg, #388E3C, #1976D2);
}

.pagination {
  margin-top: 40px;
  text-align: center;
}

.pagination :deep(.el-pagination.is-background .el-pager li:not(.is-disabled).is-active) {
  background: linear-gradient(135deg, #4CAF50, #2196F3);
}

.exchange-dialog :deep(.el-dialog__header) {
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  color: white;
  padding: 15px 20px;
  border-radius: 15px 15px 0 0;
}

.exchange-dialog :deep(.el-dialog__title) {
  color: white;
  font-weight: bold;
  font-size: 20px;
}

.exchange-dialog :deep(.el-dialog__body) {
  padding: 0;
}

.exchange-dialog :deep(.el-dialog__footer) {
  padding: 15px 20px 20px;
  border-top: 1px solid #eee;
}

.exchange-dialog :deep(.el-dialog) {
  border-radius: 15px;
  overflow: hidden;
}

.dialog-goods-preview {
  display: flex;
  padding: 20px;
  background: linear-gradient(to right, rgba(76, 175, 80, 0.05), rgba(33, 150, 243, 0.05));
  border-bottom: 1px solid #eee;
}

.preview-image {
  width: 100px;
  height: 100px;
  border-radius: 10px;
  overflow: hidden;
  margin-right: 20px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.preview-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.preview-info h3 {
  font-size: 18px;
  margin: 0 0 10px 0;
  color: #333;
}

.preview-info p {
  color: #666;
  margin: 0;
  font-size: 14px;
}

.exchange-form {
  padding: 20px;
}

.form-input :deep(.el-input__wrapper),
.form-input :deep(.el-textarea__wrapper) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05) !important;
  border-radius: 10px !important;
  padding: 8px 15px;
  transition: all 0.3s ease;
}

.form-input :deep(.el-input__wrapper):hover,
.form-input :deep(.el-textarea__wrapper):hover {
  box-shadow: 0 4px 12px rgba(76, 175, 80, 0.15) !important;
  transform: translateY(-2px);
}

.score-text {
  font-size: 22px;
  color: #FFD54F;
  font-weight: 700;
  display: inline-block;
  background: linear-gradient(45deg, #FFECB3, #FFD54F);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.score-balance {
  margin-top: 15px;
  padding: 15px;
  background: rgba(33, 150, 243, 0.05);
  border-radius: 10px;
  display: flex;
  align-items: center;
  border-left: 4px solid #2196F3;
}

.score-balance .el-icon {
  font-size: 20px;
  color: #FFE082;
  margin-right: 10px;
}

.user-score {
  font-size: 22px;
  margin: 0 10px;
  color: #4CAF50;
  font-weight: 700;
}

.score-status {
  margin-left: auto;
  padding: 3px 10px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
}

.sufficient {
  background-color: rgba(76, 175, 80, 0.15);
  color: #388E3C;
}

.insufficient {
  background-color: rgba(244, 67, 54, 0.15);
  color: #D32F2F;
}

.dialog-footer {
  display: flex;
  justify-content: center;
  gap: 15px;
}

.cancel-btn {
  border-radius: 20px;
  padding: 10px 25px;
}

.confirm-btn {
  border-radius: 20px;
  padding: 10px 25px;
  background: linear-gradient(135deg, #4CAF50, #2196F3);
  border: none;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 5px;
}

.confirm-btn:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 6px 15px rgba(76, 175, 80, 0.2);
  background: linear-gradient(135deg, #388E3C, #1976D2);
}

.confirm-btn:disabled {
  opacity: 0.7;
  background: #ccc;
}
</style>