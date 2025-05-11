<template>
  <div class="score-goods-container">
    <div class="page-header">
      <div class="header-content">
        <h1>积分商城</h1>
        <p>用积分兑换心仪好物</p>
      </div>
      <div class="search-bar">
        <el-input 
          v-model="data.name" 
          placeholder="请输入物品名称查询"
          class="search-input"
          :prefix-icon="Search">
        </el-input>
        <el-button type="primary" :icon="Search" @click="load" class="search-btn">查询</el-button>
        <el-button :icon="Refresh" @click="reset" class="reset-btn">重置</el-button>
      </div>
    </div>

    <div class="goods-grid">
      <div v-for="item in data.tableData" :key="item.id" class="goods-card">
        <div class="card-image">
          <img :src="item.img" :alt="item.name">
          <div class="score-tag">{{ item.score }}积分/{{ item.unit }}</div>
        </div>
        <div class="card-content">
          <h3 class="goods-name">{{ item.name }}</h3>
          <p class="goods-description">{{ item.descr }}</p>
          <div class="goods-info">
            <span class="stock-info">
              <el-icon><Goods /></el-icon>
              剩余：{{ item.num }}{{ item.unit }}
            </span>
          </div>
          <el-button type="primary" :icon="ShoppingCart" @click="handleExchange(item)" class="exchange-btn">
            立即兑换
          </el-button>
        </div>
      </div>
    </div>

    <div class="pagination-container" v-if="data.total">
      <el-pagination
        @current-change="load"
        background
        layout="total, prev, pager, next"
        :page-size="data.pageSize"
        v-model:current-page="data.pageNum"
        :total="data.total"
      />
    </div>

    <el-dialog
      title="积分兑换"
      v-model="data.formVisible"
      width="40%"
      destroy-on-close
      class="exchange-dialog"
    >
      <el-form
        ref="formRef"
        :model="data.form"
        :rules="data.rules"
        label-width="110px"
        class="exchange-form"
      >
        <el-form-item prop="name" label="物品名称">
          <b>{{ data.goods.name }}</b>
        </el-form-item>
        <el-form-item prop="num" label="兑换数量">
          <el-input-number
            @change="calScore"
            style="width: 200px"
            :min="1"
            v-model="data.form.num"
            placeholder="请输入兑换数量"
          />
        </el-form-item>
        <el-form-item prop="score" label="消耗积分">
          <b class="score-value">{{ data.form.score }}</b>
        </el-form-item>
        <el-form-item prop="receiveName" label="接收人名称">
          <el-input v-model="data.form.receiveName" placeholder="请输入接收人名称" />
        </el-form-item>
        <el-form-item prop="receivePhone" label="接收人电话">
          <el-input v-model="data.form.receivePhone" placeholder="请输入接收人电话" />
        </el-form-item>
        <el-form-item prop="receiveAddress" label="接收人地址">
          <el-input
            type="textarea"
            :rows="3"
            v-model="data.form.receiveAddress"
            placeholder="请输入接收人地址"
          />
        </el-form-item>
        <el-form-item label="我剩余的积分">
          <b class="user-score">{{ data.userScore }}</b>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="exchange">确 定</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import request from "@/utils/request.js";
import { ElMessage, ElMessageBox } from "element-plus";
import { Search, Refresh, Goods, ShoppingCart } from '@element-plus/icons-vue';

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
.score-goods-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
}

.page-header {
  background: white;
  border-radius: 16px;
  padding: 30px;
  margin-bottom: 40px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
}

.header-content {
  text-align: center;
  margin-bottom: 30px;
}

.header-content h1 {
  font-size: 32px;
  color: #2c7a4d;
  margin-bottom: 8px;
  font-weight: 600;
}

.header-content p {
  color: #666;
  font-size: 16px;
}

.search-bar {
  display: flex;
  gap: 16px;
  justify-content: center;
  align-items: center;
}

.search-input {
  width: 300px;
}

.goods-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 24px;
  margin-bottom: 40px;
}

.goods-card {
  background: white;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  border: 2px solid #e8f5ec;
}

.goods-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(101, 181, 122, 0.12);
  border-color: #7bc88c;
}

.card-image {
  position: relative;
  padding-top: 75%;
  overflow: hidden;
}

.card-image img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.goods-card:hover .card-image img {
  transform: scale(1.05);
}

.score-tag {
  position: absolute;
  top: 16px;
  right: 16px;
  background: rgba(135, 206, 235, 0.9);
  color: white;
  padding: 6px 16px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
  backdrop-filter: blur(4px);
}

.card-content {
  padding: 20px;
}

.goods-name {
  font-size: 18px;
  color: #2c7a4d;
  margin: 0 0 12px;
  font-weight: 600;
}

.goods-description {
  color: #666;
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 16px;
  height: 44px;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.goods-info {
  display: flex;
  align-items: center;
  margin-bottom: 16px;
}

.stock-info {
  display: flex;
  align-items: center;
  gap: 6px;
  color: #666;
  font-size: 14px;
}

.pagination-container {
  display: flex;
  justify-content: center;
  margin-top: 40px;
}

.exchange-dialog :deep(.el-dialog__header) {
  padding: 20px 30px;
  margin: 0;
  border-bottom: 1px solid #e8f5ec;
}

.exchange-dialog :deep(.el-dialog__title) {
  font-size: 20px;
  color: #2c7a4d;
  font-weight: 600;
}

.exchange-form {
  padding: 30px;
}

.score-value {
  color: #f56c6c;
  font-size: 18px;
}

.user-score {
  color: #3644f4;
  font-size: 18px;
}

.dialog-footer {
  padding: 20px 30px;
  border-top: 1px solid #e8f5ec;
  text-align: right;
}

.search-btn {
  background-color: #4CAF50;
  border-color: #4CAF50;
}

.search-btn:hover {
  background-color: #45a049;
  border-color: #45a049;
}

.reset-btn {
  background-color: #9E9E9E;
  border-color: #9E9E9E;
  color: white;
}

.reset-btn:hover {
  background-color: #757575;
  border-color: #757575;
}

.exchange-btn {
  background-color: #2E7D32;
  border-color: #2E7D32;
}

.exchange-btn:hover {
  background-color: #1B5E20;
  border-color: #1B5E20;
}

@media (max-width: 768px) {
  .score-goods-container {
    padding: 20px;
  }
  
  .page-header {
    padding: 20px;
  }
  
  .header-content h1 {
    font-size: 24px;
  }
  
  .search-bar {
    flex-direction: column;
  }
  
  .search-input {
    width: 100%;
  }
  
  .goods-grid {
    grid-template-columns: 1fr;
  }
}
</style>