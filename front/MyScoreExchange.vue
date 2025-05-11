<template>
  <div class="main-content">
    <div style="margin-bottom: 20px; font-weight: bold; font-size: 24px">我的积分兑换记录</div>
    <div class="card" style="padding: 20px">
      <div style="margin-bottom: 20px">
        <el-input v-model="data.goodsName" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入积分商品名称查询"></el-input>
        <el-button type="info" plain @click="load">查询</el-button>
        <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
      </div>
      <div style="margin-bottom: 20px">
        <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange">
          <el-table-column prop="goodsName" label="物品"></el-table-column>
          <el-table-column prop="num" label="兑换物品数量"></el-table-column>
          <el-table-column prop="score" label="消耗总积分"></el-table-column>
          <el-table-column prop="receiveName" label="接收人姓名"></el-table-column>
          <el-table-column prop="receivePhone" label="接收人电话"></el-table-column>
          <el-table-column prop="receiveAddress" label="接收人地址"></el-table-column>
          <el-table-column prop="time" label="创建时间"></el-table-column>
          <el-table-column prop="status" label="兑换订单状态">
            <template v-slot="scope">
              <el-tag type="danger" v-if="scope.row.status === '已取消'">已取消</el-tag>
              <el-tag type="warning" v-if="scope.row.status === '待派送'">待派送</el-tag>
              <el-tag type="primary" v-if="scope.row.status === '派送中'">派送中</el-tag>
              <el-tag type="info" v-if="scope.row.status === '已送达'">已送达</el-tag>
              <el-tag type="success" v-if="scope.row.status === '已签收'">已签收</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="150" fixed="right">
            <template v-slot="scope">
              <el-button type="danger" @click="changeStatus(scope.row, '已取消')" v-if="scope.row.status === '待派送'">取消兑换</el-button>
              <el-button type="primary" @click="changeStatus(scope.row, '已签收')" v-if="scope.row.status === '已送达'">已签收</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <div v-if="data.total">
        <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
      </div>
    </div>


  </div>
</template>

<script setup>

import {reactive} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";
import {Delete, Edit} from "@element-plus/icons-vue";


const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  formVisible: false,
  form: {},
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
  goodsName: null,
  ids: []
})

const load = () => {
  request.get('/scoreExchange/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      goodsName: data.goodsName
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
  ElMessageBox.confirm('您确认订单' + status + '吗？', '操作', { type: 'warning' }).then(res => {
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
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { type: 'warning' }).then(res => {
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
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { type: 'warning' }).then(res => {
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