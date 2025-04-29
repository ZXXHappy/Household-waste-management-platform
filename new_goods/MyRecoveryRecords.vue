<template>
  <div class="main-content">
    <div style="margin-bottom: 20px; font-size: 24px; font-weight: bold">我的垃圾回收记录</div>
    <div class="card" style="padding: 20px">
      <div style="margin-bottom: 20px">
        <el-input v-model="data.siteName" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入社区垃圾投放点名称查询"></el-input>
        <el-button type="info" plain @click="load">查询</el-button>
        <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
      </div>

      <div style="margin-bottom: 20px">
        <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange">
          <el-table-column prop="garbageName" label="可回收垃圾类型"></el-table-column>
          <el-table-column prop="img" label="可回收垃圾照片">
            <template #default="scope">
              <el-image style="width: 100px; height: 80px; border-radius: 5px" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
            </template>
          </el-table-column>
          <el-table-column prop="communityName" label="社区"></el-table-column>
          <el-table-column prop="siteName" label="回收点"></el-table-column>
          <el-table-column prop="num" label="回收数量"></el-table-column>
          <el-table-column prop="score" label="总计积分"></el-table-column>
          <el-table-column prop="time" label="申请时间"></el-table-column>
          <el-table-column prop="remark" label="备注"></el-table-column>
          <el-table-column prop="status" label="回收状态">
            <template v-slot="scope">
              <el-tag type="warning" v-if="scope.row.status === '待审核'">待审核</el-tag>
              <el-tag type="success" v-if="scope.row.status === '通过'">通过</el-tag>
              <el-tag type="danger" v-if="scope.row.status === '拒绝'">拒绝</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="rejectReason" label="拒绝备注"></el-table-column>
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
  siteName: null,
  ids: []
})

const baseUrl = import.meta.env.VITE_BASE_URL
const handleFileUpload = (res) => {
  data.form.img = res.data
}

const load = () => {
  request.get('/recoveryRecords/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      siteName: data.siteName
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
  request.post('/recoveryRecords/add', data.form).then(res => {
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
  if (data.form.status === '待审核') {
    ElMessage.error('请审批')
    return
  }
  if (data.form.status === '拒绝' && !data.form.rejectReason) {
    ElMessage.error('请填写拒绝理由')
    return
  }
  request.put('/recoveryRecords/update', data.form).then(res => {
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
    request.delete('/recoveryRecords/delete/' + id).then(res => {
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
    request.delete("/recoveryRecords/delete/batch", {data: data.ids}).then(res => {
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
  data.siteName = null
  load()
}

load()
</script>