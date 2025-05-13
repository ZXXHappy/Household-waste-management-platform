<template>
  <div>
    <div class="card search-card">
      <el-input v-model="data.title" prefix-icon="Search" class="search-input" placeholder="请输入反馈标题查询"></el-input>
      <el-button type="info" plain @click="load">查询</el-button>
      <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>
    <div class="card action-card">
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="card table-card">
      <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange" border>
        <el-table-column type="selection" width="55" />
        <el-table-column prop="userName" label="用户"></el-table-column>
        <el-table-column prop="title" label="反馈标题" show-overflow-tooltip></el-table-column>
        <el-table-column prop="idea" label="反馈想法" show-overflow-tooltip></el-table-column>
        <el-table-column prop="content" label="反馈问题" show-overflow-tooltip></el-table-column>
        <el-table-column prop="time" label="反馈时间"></el-table-column>
        <el-table-column prop="replyContent" label="回复内容" show-overflow-tooltip></el-table-column>
        <el-table-column prop="replyTime" label="回复时间"></el-table-column>
        <el-table-column prop="status" label="回复状态">
          <template v-slot="scope">
            <el-tag type="warning" effect="light" v-if="scope.row.status === '待回复'">待回复</el-tag>
            <el-tag type="success" effect="light" v-if="scope.row.status === '已回复'">已回复</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150" fixed="right">
          <template v-slot="scope">
            <el-button type="primary" size="small" @click="handleEdit(scope.row)">回复</el-button>
            <el-button type="danger" size="small" circle :icon="Delete" @click="del(scope.row.id)"></el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="card pagination-card" v-if="data.total">
      <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
    </div>

    <el-dialog title="回复反馈" v-model="data.formVisible" width="40%" destroy-on-close>
      <el-form ref="formRef" :model="data.form" label-width="90px" style="padding: 20px">
        <el-form-item prop="replayContent" label="回复内容">
          <el-input type="textarea" :rows="3" v-model="data.form.replyContent" placeholder="请输入回复内容"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="save">确 定</el-button>
        </span>
      </template>
    </el-dialog>

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
  title: null,
  ids: []
})

const baseUrl = import.meta.env.VITE_BASE_URL
const handleFileUpload = (res) => {
  data.form.img = res.data
}

const load = () => {
  request.get('/feedback/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      title: data.title
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
  request.post('/feedback/add', data.form).then(res => {
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
  request.put('/feedback/update', data.form).then(res => {
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
    request.delete('/feedback/delete/' + id).then(res => {
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
    request.delete("/feedback/delete/batch", {data: data.ids}).then(res => {
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
  data.title = null
  load()
}

load()
</script>

<style scoped>
.search-card, .action-card {
  margin-bottom: 15px;
  display: flex;
  align-items: center;
}

.search-input {
  width: 240px;
  margin-right: 10px;
}

.table-card {
  margin-bottom: 15px;
  overflow: hidden;
}

.pagination-card {
  display: flex;
  justify-content: center;
}

:deep(.el-tag) {
  padding: 4px 8px;
  border-radius: 4px;
  font-weight: 500;
}
</style>