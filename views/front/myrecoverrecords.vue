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


</script>