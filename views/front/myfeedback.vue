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

</script>