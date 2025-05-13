<template>
  <div class="main-content">
    <div style="font-size: 24px; font-weight: bold; margin-bottom: 20px">我的反馈</div>
    <div class="card" style="padding: 20px">
      <div style="margin-bottom: 20px; display: flex; align-items: center">
        <div style="flex: 1">
          <el-button type="danger" plain @click="delBatch">批量删除</el-button>
        </div>
       <div>
         <el-input v-model="data.title" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入反馈标题查询"></el-input>
         <el-button type="info" plain @click="load">查询</el-button>
         <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
       </div>
      </div>

      <div style="margin-bottom: 20px">
        <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange">
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
              <el-tag type="warning" v-if="scope.row.status === '待回复'">待回复</el-tag>
              <el-tag type="success" v-if="scope.row.status === '已回复'">已回复</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="100" fixed="right">
            <template v-slot="scope">
              <el-button type="primary" circle :icon="Edit" @click="handleEdit(scope.row)" v-if="scope.row.status === '待回复'"></el-button>
              <el-button type="danger" circle :icon="Delete" @click="del(scope.row.id)"></el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <div v-if="data.total">
        <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
      </div>
    </div>


    <el-dialog title="反馈信息" v-model="data.formVisible" width="40%" destroy-on-close>
      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="70px" style="padding: 20px">
        <el-form-item prop="title" label="标题">
          <el-input v-model="data.form.title" placeholder="请输入标题"></el-input>
        </el-form-item>
        <el-form-item prop="content" label="内容">
          <el-input type="textarea" :rows="3" v-model="data.form.content" placeholder="请输入内容"></el-input>
        </el-form-item>
        <el-form-item prop="idea" label="想法">
          <el-input type="textarea" :rows="3" v-model="data.form.idea" placeholder="请输入想法"></el-input>
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

import {reactive, ref} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";
import {Delete, Edit} from "@element-plus/icons-vue";

const formRef = ref()
const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  formVisible: false,
  form: {},
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
  title: null,
  ids: [],
  rules: {
    title: [
      { required: true, message: '请输入反馈标题', trigger: 'blur' }
    ],
    content: [
      { required: true, message: '请输入反馈内容', trigger: 'blur' }
    ],
    idea: [
      { required: true, message: '请输入您的想法', trigger: 'blur' }
    ]
  }
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
  formRef.value.validate((valid) => {
    if (valid) {
      data.form.id ? update() : add()
    }
  })
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