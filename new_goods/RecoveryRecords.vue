<template>
  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.siteName" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入社区垃圾投放点名称查询"></el-input>
      <el-button type="info" plain @click="load">查询</el-button>
      <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px" v-if="data.user.role === 'ADMIN'">
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" v-if="data.user.role === 'ADMIN'" />
        <el-table-column prop="garbageName" label="可回收垃圾类型"></el-table-column>
        <el-table-column prop="img" label="可回收垃圾照片">
          <template #default="scope">
            <el-image style="width: 100px; height: 80px; border-radius: 5px" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="用户"></el-table-column>
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
        <el-table-column label="操作" width="100" fixed="right">
          <template v-slot="scope">
            <el-button type="success" v-if="data.user.role === 'COMMUNITY' && scope.row.status === '待审核'" @click="handleEdit(scope.row)">审批</el-button>
            <el-button type="danger" circle :icon="Delete" @click="del(scope.row.id)" v-if="data.user.role === 'ADMIN'"></el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
    </div>

    <el-dialog title="回收申请审批" v-model="data.formVisible" width="40%" destroy-on-close>
      <el-form ref="form" :model="data.form" label-width="70px" style="padding: 20px">
        <el-form-item prop="name" label="审核状态">
          <el-radio-group v-model="data.form.status">
            <el-radio-button label="通过" value="通过"></el-radio-button>
            <el-radio-button label="拒绝" value="拒绝"></el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="拒绝备注">
         <el-input :disabled="data.form.status !== '拒绝'" type="textarea" :rows="3" v-model="data.form.rejectReason" placeholder="请输入拒绝理由"></el-input>
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


</script>