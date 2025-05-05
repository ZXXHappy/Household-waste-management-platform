<template>
  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.goodsName" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入积分商品名称查询"></el-input>
      <el-button type="info" plain @click="load">查询</el-button>
      <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" />
        <el-table-column prop="userName" label="兑换人"></el-table-column>
        <el-table-column prop="goodsName" label="物品"></el-table-column>
        <el-table-column prop="num" label="兑换物品数量"></el-table-column>
        <el-table-column prop="score" label="消耗总积分"></el-table-column>
        <el-table-column prop="receiveName" label="接收人姓名"></el-table-column>
        <el-table-column prop="receivePhone" label="接收人电话"></el-table-column>
        <el-table-column prop="receiveAddress" label="接收人地址"></el-table-column>
        <el-table-column prop="time" label="创建时间"></el-table-column>
        <el-table-column prop="status" label="兑换订单状态">
          <template v-slot="scope">
            <el-tag type="danger" v-if="scope.row.status === '已取消'">已取消</el-tag>
            <el-tag type="warning" v-if="scope.row.status === '待派送'">待派送</el-tag>
            <el-tag type="primary" v-if="scope.row.status === '派送中'">派送中</el-tag>
            <el-tag type="info" v-if="scope.row.status === '已送达'">已送达</el-tag>
            <el-tag type="success" v-if="scope.row.status === '已签收'">已签收</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150" fixed="right">
          <template v-slot="scope">
            <el-button type="primary" @click="changeStatus(scope.row, '派送中')" v-if="scope.row.status === '待派送'">已派送</el-button>
            <el-button type="info" @click="changeStatus(scope.row, '已送达')" v-if="scope.row.status === '派送中'">已送达</el-button>
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