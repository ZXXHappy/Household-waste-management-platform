<template>
  <div>
    <div class="card search-card">
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input v-model="data.siteName" prefix-icon="Search" clearable placeholder="请输入社区垃圾投放点名称查询">
            <template #prefix>
              <el-icon><Search /></el-icon>
            </template>
          </el-input>
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
        <el-table-column prop="garbageName" label="可回收垃圾类型" />
        <el-table-column prop="img" label="可回收垃圾照片" width="120">
          <template #default="scope">
            <el-image 
              style="width: 100px; height: 80px; border-radius: 4px; object-fit: cover;" 
              :src="scope.row.img" 
              :preview-src-list="[scope.row.img]" 
              preview-teleported
            />
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="用户" width="100" />
        <el-table-column prop="communityName" label="社区" width="120" />
        <el-table-column prop="siteName" label="回收点" width="120" />
        <el-table-column prop="num" label="回收数量" width="90" align="center" />
        <el-table-column prop="score" label="总计积分" width="90" align="center">
          <template #default="scope">
            <span class="score-value">{{ scope.row.score }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="time" label="申请时间" width="150" />
        <el-table-column prop="remark" label="备注" show-overflow-tooltip />
        <el-table-column prop="status" label="回收状态" width="100" align="center">
          <template #default="scope">
            <el-tag 
              :type="getStatusType(scope.row.status)" 
              effect="light" 
              size="small" 
              round
            >
              {{ scope.row.status }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="rejectReason" label="拒绝备注" show-overflow-tooltip />
        <el-table-column label="操作" width="120" fixed="right">
          <template #default="scope">
            <el-button 
              type="success" 
              size="small" 
              v-if="data.user.role === 'COMMUNITY' && scope.row.status === '待审核'" 
              @click="handleEdit(scope.row)"
            >
              <el-icon><Check /></el-icon>审批
            </el-button>
            <el-button 
              type="danger" 
              size="small"
              circle 
              :icon="Delete" 
              @click="del(scope.row.id)" 
              v-if="data.user.role === 'ADMIN'"
            />
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

    <el-dialog 
      title="回收申请审批" 
      v-model="data.formVisible" 
      width="500px" 
      destroy-on-close
      :close-on-click-modal="false"
    >
      <div class="approval-info" v-if="data.form.id">
        <div class="approval-item">
          <span class="approval-label">垃圾类型:</span>
          <span class="approval-value">{{ data.form.garbageName }}</span>
        </div>
        <div class="approval-item">
          <span class="approval-label">申请人:</span>
          <span class="approval-value">{{ data.form.userName }}</span>
        </div>
        <div class="approval-item">
          <span class="approval-label">回收点:</span>
          <span class="approval-value">{{ data.form.siteName }}</span>
        </div>
        <div class="approval-item">
          <span class="approval-label">申请数量:</span>
          <span class="approval-value">{{ data.form.num }}</span>
        </div>
        <div class="approval-item">
          <span class="approval-label">积分:</span>
          <span class="approval-value score">{{ data.form.score }}</span>
        </div>
        <div class="approval-photo">
          <span class="approval-label">照片:</span>
          <el-image 
            style="width: 200px; height: 150px; object-fit: cover; border-radius: 4px;" 
            :src="data.form.img" 
            :preview-src-list="[data.form.img]"
            preview-teleported
          />
        </div>
      </div>
      
      <el-divider content-position="center">审批决定</el-divider>
      
      <el-form ref="form" :model="data.form" label-width="80px" class="approval-form">
        <el-form-item prop="status" label="审核状态" required>
          <el-radio-group v-model="data.form.status" size="large">
            <el-radio-button label="通过">
              <el-icon><CircleCheck /></el-icon>通过
            </el-radio-button>
            <el-radio-button label="拒绝">
              <el-icon><CircleClose /></el-icon>拒绝
            </el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="拒绝备注" v-show="data.form.status === '拒绝'">
         <el-input 
           :disabled="data.form.status !== '拒绝'" 
           type="textarea" 
           :rows="3" 
           v-model="data.form.rejectReason" 
           placeholder="请输入拒绝理由"
         />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="save" :loading="data.submitLoading">
            <el-icon><Check /></el-icon>确认提交
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import { ElMessage, ElMessageBox } from "element-plus";
import { 
  Delete, Edit, Search, RefreshLeft, Check, 
  CircleCheck, CircleClose, Tickets 
} from "@element-plus/icons-vue";

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  formVisible: false,
  form: {},
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
  siteName: null,
  ids: [],
  loading: false,
  submitLoading: false
})

const getStatusType = (status) => {
  switch (status) {
    case '待审核': return 'warning';
    case '通过': return 'success';
    case '拒绝': return 'danger';
    default: return 'info';
  }
}

const baseUrl = import.meta.env.VITE_BASE_URL
const handleFileUpload = (res) => {
  data.form.img = res.data
}

const load = () => {
  data.loading = true;
  request.get('/recoveryRecords/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      siteName: data.siteName
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
  data.submitLoading = true;
  request.post('/recoveryRecords/add', data.form).then(res => {
    data.submitLoading = false;
    if (res.code === '200') {
      ElMessage.success('操作成功')
      data.formVisible = false
      load()
    } else {
      ElMessage.error(res.msg)
    }
  }).catch(() => {
    data.submitLoading = false;
  })
}

const update = () => {
  if (data.form.status === '待审核') {
    ElMessage.warning('请选择审批结果')
    return
  }
  if (data.form.status === '拒绝' && !data.form.rejectReason) {
    ElMessage.warning('请填写拒绝理由')
    return
  }
  
  data.submitLoading = true;
  request.put('/recoveryRecords/update', data.form).then(res => {
    data.submitLoading = false;
    if (res.code === '200') {
      ElMessage.success('审批操作成功')
      data.formVisible = false
      load()
    } else {
      ElMessage.error(res.msg)
    }
  }).catch(() => {
    data.submitLoading = false;
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
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { 
    type: 'warning',
    confirmButtonText: '确认删除',
    cancelButtonText: '取消'
  }).then(res => {
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

.score-value {
  font-weight: 600;
  color: #f59e0b;
}

.approval-info {
  background-color: #f8fafc;
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 20px;
}

.approval-item {
  display: flex;
  margin-bottom: 10px;
}

.approval-label {
  font-weight: 500;
  color: #606266;
  width: 80px;
  flex-shrink: 0;
}

.approval-value {
  color: #303133;
}

.approval-value.score {
  font-weight: 600;
  color: #f59e0b;
}

.approval-photo {
  margin-top: 15px;
  display: flex;
}

.approval-form {
  margin-top: 20px;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style>