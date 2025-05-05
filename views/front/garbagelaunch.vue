<template>
  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.communityName" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入社区名称查询"></el-input>
      <el-button type="info" plain @click="load">查询</el-button>
      <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px" v-if="data.user.role === 'ADMIN'">
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" v-if="data.user.role === 'ADMIN'" />
        <el-table-column prop="userName" label="用户名称"></el-table-column>
        <el-table-column prop="communityName" label="社区"></el-table-column>
        <el-table-column prop="siteName" label="投放点"></el-table-column>
        <el-table-column prop="type" label="垃圾类型"></el-table-column>
        <el-table-column prop="img" label="垃圾照片">
          <template #default="scope">
            <el-image style="width: 100px; height: 80px; border-radius: 5px" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="time" label="投放时间"></el-table-column>
        <el-table-column label="操作" width="100" fixed="right" v-if="data.user.role === 'ADMIN'">
          <template v-slot="scope">
            <el-button type="danger" circle :icon="Delete" @click="del(scope.row.id)"></el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
    </div>

  </div>
</template>

<script setup>

</script>