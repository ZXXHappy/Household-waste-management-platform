<template>
  <div>
    <div class="card search-card">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input v-model="data.name" prefix-icon="Search" clearable placeholder="请输入社区名称查询"></el-input>
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
    
    <div class="card action-card" v-if="data.user.role === 'ADMIN'">
      <el-button type="primary" @click="handleAdd">
        <el-icon><Plus /></el-icon>新增社区
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
        <el-table-column type="selection" width="55" v-if="data.user.role === 'ADMIN'" />
        <el-table-column prop="name" label="社区名称"></el-table-column>
        <el-table-column prop="address" label="社区地址" show-overflow-tooltip></el-table-column>
        <el-table-column prop="img" label="社区图片">
          <template #default="scope">
            <el-image style="width: 100px; height: 60px; border-radius: 4px; object-fit: cover;" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="managerName" label="社区负责人"></el-table-column>
        <el-table-column label="操作" width="120" fixed="right" v-if="data.user.role === 'ADMIN'">
          <template v-slot="scope">
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

    <el-dialog title="社区信息" v-model="data.formVisible" width="40%" destroy-on-close>
      <el-form ref="form" :model="data.form" label-width="90px" style="padding: 20px">
        <el-form-item prop="name" label="社区名称">
          <el-input v-model="data.form.name" placeholder="请输入社区名称"></el-input>
        </el-form-item>
        <el-form-item prop="address" label="社区地址">
          <el-input type="textarea" :rows="3" v-model="data.form.address" placeholder="请输入社区地址"></el-input>
        </el-form-item>
        <el-form-item prop="img" label="社区图片">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload"
              list-type="picture"
          >
            <el-button type="primary">上传</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="managerId" label="社区负责人">
          <el-select style="width: 100%" v-model="data.form.managerId">
            <el-option v-for="item in data.communityAdminList" :key="item.id" :value="item.id" :label="item.name"></el-option>
          </el-select>
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
import { Delete, Edit, Search, RefreshLeft, Plus } from "@element-plus/icons-vue";

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
  communityAdminList: [],
  loading: false
})

const baseUrl = import.meta.env.VITE_BASE_URL
const handleFileUpload = (res) => {
  data.form.img = res.data
}

request.get('/communityAdmin/selectAll').then(res => {
  data.communityAdminList = res.data
})

const load = () => {
  data.loading = true;
  request.get('/community/selectPage', {
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
  request.post('/community/add', data.form).then(res => {
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
  request.put('/community/update', data.form).then(res => {
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
    request.delete('/community/delete/' + id).then(res => {
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
    request.delete("/community/delete/batch", {data: data.ids}).then(res => {
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
</style>