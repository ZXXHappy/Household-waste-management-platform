<template>
  <div>
    <div class="card search-card">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input v-model="data.name" prefix-icon="Search" clearable placeholder="请输入名称查询"></el-input>
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
      <el-button type="primary" @click="handleAdd">
        <el-icon><Plus /></el-icon>新增
      </el-button>
      <el-button type="danger" @click="delBatch">
        <el-icon><Delete /></el-icon>批量删除
      </el-button>
    </div>

    <div class="card table-view">
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
        <el-table-column prop="username" label="账号" />
        <el-table-column prop="avatar" label="头像" width="90">
          <template #default="scope">
            <el-image 
              style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; box-shadow: 0 2px 5px rgba(0,0,0,0.1);" 
              v-if="scope.row.avatar"
              :src="scope.row.avatar" 
              :preview-src-list="[scope.row.avatar]" 
              preview-teleported>
              <template #error>
                <div class="image-placeholder">
                  <el-icon><Avatar /></el-icon>
                </div>
              </template>
            </el-image>
          </template>
        </el-table-column>
        <el-table-column prop="name" label="姓名" />
        <el-table-column prop="role" label="角色">
          <template #default="scope">
            <el-tag type="success" effect="plain" size="small">{{ scope.row.role }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="phone" label="电话" />
        <el-table-column prop="email" label="邮箱" show-overflow-tooltip />
        <el-table-column label="操作" width="120" fixed="right">
          <template #default="scope">
            <el-button type="primary" size="small" circle :icon="Edit" @click="handleEdit(scope.row)"></el-button>
            <el-button type="danger" size="small" circle :icon="Delete" @click="del(scope.row.id)"></el-button>
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

    <el-dialog title="管理员信息" v-model="data.formVisible" width="40%" destroy-on-close>
      <el-form ref="form" :model="data.form" label-width="80px" style="padding: 20px">
        <el-form-item prop="username" label="用户名">
          <el-input v-model="data.form.username" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item prop="avatar" label="头像">
          <el-upload
            :action="baseUrl + '/files/upload'"
            :on-success="handleFileUpload"
            list-type="picture"
            :headers="{ 'token': JSON.parse(localStorage.getItem('xm-user') || '{}').token }"
          >
            <el-button type="primary">
              <el-icon><Upload /></el-icon>上传头像
            </el-button>
            <div class="upload-tip" v-if="data.form.avatar">
              <img :src="data.form.avatar" class="avatar-preview" />
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item prop="name" label="姓名">
          <el-input v-model="data.form.name" placeholder="请输入姓名"></el-input>
        </el-form-item>
        <el-form-item prop="phone" label="电话">
          <el-input v-model="data.form.phone" placeholder="请输入电话"></el-input>
        </el-form-item>
        <el-form-item prop="email" label="邮箱">
          <el-input v-model="data.form.email" placeholder="请输入邮箱"></el-input>
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
import { reactive } from "vue";
import request from "@/utils/request.js";
import { ElMessage, ElMessageBox } from "element-plus";
import { Delete, Edit, Search, RefreshLeft, Plus, Upload, Avatar } from "@element-plus/icons-vue";

const baseUrl = import.meta.env.VITE_BASE_URL

const data = reactive({
  formVisible: false,
  form: {},
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
  name: null,
  ids: [],
  loading: false
})

const load = () => {
  data.loading = true;
  request.get('/admin/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name
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
  request.post('/admin/add', data.form).then(res => {
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
  request.put('/admin/update', data.form).then(res => {
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
    request.delete('/admin/delete/' + id).then(res => {
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
    request.delete("/admin/delete/batch", {data: data.ids}).then(res => {
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

const handleFileUpload = (res) => {
  data.form.avatar = res.data
}

const reset = () => {
  data.name = null
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

.table-view {
  margin-bottom: 15px;
}

.pagination-container {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.image-placeholder {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50px;
  height: 50px;
  background-color: #f5f7fa;
  color: #909399;
  border-radius: 50%;
}

.image-placeholder .el-icon {
  font-size: 24px;
}

.upload-tip {
  margin-top: 10px;
}

.avatar-preview {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  border: 1px solid #ebeef5;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
</style>