<template>
  <div class="main-content" style="width: 70%">
    <div style="margin-bottom: 20px">
      <el-input size="large" v-model="data.name" prefix-icon="Search" style="width: 300px; margin-right: 10px" placeholder="请输入物品名称查询"></el-input>
      <el-button size="large" type="info" plain @click="load">查询</el-button>
      <el-button size="large" type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>

    <div style="margin-bottom: 20px">
      <el-row :gutter="20">
       <el-col :span="6" v-for="item in data.tableData" :key="item.id">
         <div class="card" style="padding: 0; margin-bottom: 20px">
           <img :src="item.img" alt="" style="width: 100%; height: 260px; border-radius: 5px 5px 0 0">
           <div style="padding: 10px">
             <div style="font-size: 20px">{{ item.name }}</div>
             <div style="margin: 10px 0; color: #666; height: 40px; line-height: 20px; text-align: justify" class="line2">{{ item.descr }}</div>
             <div style="margin: 10px 0; color: #666">剩余数量：{{ item.num }} {{item.unit}}</div>
             <div style="display: flex; align-items: center">
               <div style="flex: 1; color: red; font-weight: bold">{{item.score }}积分/{{item.unit }}</div>
               <el-button type="primary" @click="handleExchange(item)">立即兑换</el-button>
             </div>
           </div>
         </div>

       </el-col>
      </el-row>
    </div>

    <div v-if="data.total">
      <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
    </div>

    <el-dialog title="积分兑换" v-model="data.formVisible" width="40%" destroy-on-close>
      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="110px" style="padding: 20px">
        <el-form-item prop="name" label="物品名称">
          <b>{{ data.goods.name }}</b>
        </el-form-item>
        <el-form-item prop="num" label="兑换数量">
          <el-input-number @click="calScore" style="width: 200px" :min="1" v-model="data.form.num" placeholder="请输入兑换数量"></el-input-number>
        </el-form-item>
        <el-form-item prop="score" label="消耗积分">
          <b>{{ data.form.score }}</b>
        </el-form-item>
        <el-form-item prop="receiveName" label="接收人名称">
          <el-input v-model="data.form.receiveName" placeholder="请输入接收人名称"></el-input>
        </el-form-item>
        <el-form-item prop="receivePhone" label="接收人电话">
          <el-input v-model="data.form.receivePhone" placeholder="请输入接收人电话"></el-input>
        </el-form-item>
        <el-form-item prop="receiveAddress" label="接收人地址">
          <el-input type="textarea" :rows="3" v-model="data.form.receiveAddress" placeholder="请输入接收人地址"></el-input>
        </el-form-item>
        <el-form-item label="我剩余的积分">
          <b style="color: #3644f4">{{ data.userScore }}</b>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="exchange">确 定</el-button>
        </span>
      </template>
    </el-dialog>

  </div>
</template>

<script setup>

</script>
