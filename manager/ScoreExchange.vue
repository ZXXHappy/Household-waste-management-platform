<template>
  <div>
    <div class="card search-card">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input v-model="data.goodsName" prefix-icon="Search" clearable placeholder="请输入积分商品名称查询"></el-input>
        </el-col>
        <el-col :span="6" style="display: flex; gap: 10px">
          <el-button type="primary" @click="load">
            <el-icon><Search /></el-icon>查询
          </el-button>
          <el-button @click="reset">
            <el-icon><RefreshLeft /></el-icon>重置
          </el-button>
        </el-col>
      </el-row>
    </div>
    
    <div class="card action-card">
      <el-button type="danger" @click="delBatch">
        <el-icon><Delete /></el-icon>批量删除
      </el-button>
    </div>

    <div class="card">
      <el-table 
        stripe 
        border 
        :data="data.tableData" 
        @selection-change="handleSelectionChange"
        :header-cell-style="{ background: '#f8fafc', color: '#606266', fontWeight: '500' }"
        style="width: 100%"
        v-loading="data.loading"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="userName" label="兑换人"></el-table-column>
        <el-table-column prop="goodsName" label="物品"></el-table-column>
        <el-table-column prop="num" label="兑换物品数量"></el-table-column>
        <el-table-column prop="score" label="消耗总积分"></el-table-column>
        <el-table-column prop="receiveName" label="接收人姓名"></el-table-column>
        <el-table-column prop="receivePhone" label="接收人电话"></el-table-column>
        <el-table-column prop="receiveAddress" label="接收人地址" show-overflow-tooltip></el-table-column>
        <el-table-column prop="time" label="创建时间"></el-table-column>
        <el-table-column prop="status" label="兑换订单状态" width="100">
          <template v-slot="scope">
            <el-tag 
              :type="getStatusType(scope.row.status)" 
              effect="dark" 
              size="small" 
              round
            >
              {{ scope.row.status }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="170" fixed="right">
          <template v-slot="scope">
            <el-button type="primary" size="small" @click="changeStatus(scope.row, '派送中')" v-if="scope.row.status === '待派送'">
              <el-icon><Van /></el-icon>已派送
            </el-button>
            <el-button type="success" size="small" @click="changeStatus(scope.row, '已送达')" v-if="scope.row.status === '派送中'">
              <el-icon><Check /></el-icon>已送达
            </el-button>
            <el-button type="danger" circle size="small" :icon="Delete" @click="del(scope.row.id)"></el-button>
          </template>
        </el-table-column>
      </el-table>
      
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
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import { ElMessage, ElMessageBox } from "element-plus";
import { Delete, Edit, Search, RefreshLeft, Van, Check } from "@element-plus/icons-vue";

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  formVisible: false,
  form: {},
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
  goodsName: null,
  ids: [],
  loading: false
})

const getStatusType = (status) => {
  switch (status) {
    case '已取消': return 'danger';
    case '待派送': return 'warning';
    case '派送中': return 'primary';
    case '已送达': return 'info';
    case '已签收': return 'success';
    default: return '';
  }
}

const baseUrl = import.meta.env.VITE_BASE_URL

const load = () => {
  data.loading = true;
  request.get('/scoreExchange/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      goodsName: data.goodsName
    }
  }).then(res => {
    data.loading = false;
    if (res.code === '200') {
      data.tableData = res.data?.list || []
      data.total = res.data?.total
    } else {
      ElMessage.error(res.msg)
    }
  }).catch(() => {
    data.loading = false;
  })
}

const handleAdd = () => {
  data.form = {}
  data.formVisible = true
}
const handleEdit = (row) => {
  data.form = JSON.parse(JSON.stringify(row))
  data.formVisible = true
}
const add = () => {
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

const changeStatus = (row, status) => {
  ElMessageBox.confirm('您确认订单' + status + '吗？', '操作', { 
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消' 
  }).then(res => {
    data.form = JSON.parse(JSON.stringify(row))
    data.form.status = status
    request.put('/scoreExchange/update', data.form).then(res => {
      if (res.code === '200') {
        ElMessage.success('操作成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  })
}

const update = () => {
  request.put('/scoreExchange/update', data.form).then(res => {
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
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { 
    type: 'warning',
    confirmButtonText: '确认删除',
    cancelButtonText: '取消' 
  }).then(res => {
    request.delete('/scoreExchange/delete/' + id).then(res => {
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
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { 
    type: 'warning',
    confirmButtonText: '确认删除',
    cancelButtonText: '取消'
  }).then(res => {
    request.delete("/scoreExchange/delete/batch", {data: data.ids}).then(res => {
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
  data.goodsName = null
  load()
}

load()
</script>

<style scoped>
.search-card {
  margin-bottom: 15px;
}

.action-card {
  margin-bottom: 15px;
}

.pagination-container {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}
</style>