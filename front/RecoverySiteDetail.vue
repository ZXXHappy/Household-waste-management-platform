<template>
  <div style="width: 60%; margin: 10px auto 50px auto">
    <div style="margin-bottom: 20px; font-size: 20px">{{ data.recoverySite.communityName }} > {{ data.recoverySite.name }}</div>
    <div style="margin-bottom: 20px">
      <img :src="data.recoverySite.img" alt="" style="width: 100%; height: 400px">
    </div>

    <div style="display: flex; grid-gap: 20px">
      <div style="width: 300px">
        <div style="font-size: 24px; font-weight: bold; margin-bottom: 20px; text-align: center">可回收物品</div>
        <div v-for="item in data.recycleGarbageList" :key="item.id">
          <div class="card" style="margin-bottom: 10px">
            <img :src="item.img" alt="" style="width: 100%; height: 200px">
            <div style="margin: 10px 0; font-size: 18px">{{ item.name }}</div>
            <div style="color: #666; margin: 10px 0;">{{ item.descr }}</div>
            <div style="color: red">{{ item.points }}积分/{{ item.unit }}</div>
          </div>
        </div>
      </div>

      <div style="flex: 1">
        <div class="card" style="padding: 20px; margin-bottom: 20px">
          <div style="display: flex; align-items: center">
            <div style="flex: 1; font-size: 20px; font-weight: bold; ">{{ data.recoverySite.name}}</div>
            <el-button type="primary" @click="handleAdd">投放垃圾</el-button>
            <el-button type="success" @click="handleAdd1">回收申请</el-button>
          </div>
          <div style="color: #666; margin: 10px 0">所属社区：<span style="color: #333">{{ data.recoverySite.communityName}}</span></div>
          <div style="color: #666; margin: 10px 0">开放时间：<span style="color: #333">{{ data.recoverySite.timeRange}}</span></div>
          <div style="color: #666; margin: 10px 0">负责人：<span style="color: #333">{{ data.recoverySite.managerName}}</span></div>
          <div style="color: #666; margin: 10px 0">联系电话：<span style="color: #333">{{ data.recoverySite.managerPhone }}</span></div>
        </div>

        <div class="card" style="padding: 20px">
          <div v-html="data.recoverySite.content"></div>
        </div>
      </div>
    </div>

    <el-dialog title="投放垃圾" v-model="data.formVisible" width="40%" destroy-on-close>
      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="100px" style="padding: 20px">
        <el-form-item prop="img" label="垃圾照片">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload"
              list-type="picture"
          >
            <el-button type="primary">上传垃圾照片</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="type" label="垃圾类型">
          <el-select placeholder="请输入垃圾的类型" v-model="data.form.type">
            <el-option label="干垃圾" value="干垃圾"></el-option>
            <el-option label="湿垃圾" value="湿垃圾"></el-option>
            <el-option label="有害垃圾" value="有害垃圾"></el-option>
            <el-option label="厨余垃圾" value="厨余垃圾"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="add">确 定</el-button>
        </span>
      </template>
    </el-dialog>

    <el-dialog title="垃圾回收申请" v-model="data.formVisible1" width="40%" destroy-on-close>
      <el-form ref="formRef1" :model="data.form1" :rules="data.rules1" label-width="140px" style="padding: 20px">
        <el-form-item prop="garbageId" label="可回收垃圾类型">
          <el-select @change="calScore" placeholder="请选择可回收垃圾的类型" v-model="data.form1.garbageId">
            <el-option v-for="item in data.recycleGarbageList" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="img" label="垃圾照片">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload1"
              list-type="picture"
          >
            <el-button type="primary">上传垃圾照片</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="num" label="回收数量">
          <el-input-number @change="calScore" v-model="data.form1.num" :min="1" placeholder="请输入数量"></el-input-number>
          <span style="margin-left: 5px">{{ data.form1.unit}}</span>
        </el-form-item>
        <el-form-item prop="num" label="可获得积分">
          {{ data.form1.score }}
        </el-form-item>
        <el-form-item prop="remark" label="备注">
          <el-input type="textarea" :rows="3" v-model="data.form1.remark" :min="1" placeholder="请输入备注"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible1 = false">取 消</el-button>
          <el-button type="primary" @click="addRecovery">确 定</el-button>
        </span>
      </template>
    </el-dialog>


  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  id: router.currentRoute.value.query.id,
  recoverySite: {},
  recycleGarbageList: [],
  formVisible: false,
  form: {},
  rules: {
    type: [
      { required: true, message: '请输入垃圾类型', trigger: 'change' }
    ]
  },
  formVisible1: false,
  form1: {},
  rules1: {
    garbageId: [
      { required: true, message: '请选择可回收垃圾类型', trigger: 'change' }
    ]
  },
})

const formRef = ref()
const formRef1 = ref()

const calScore = () => {
  if (data.form1.garbageId) {
    let garbage =  data.recycleGarbageList.find(v => v.id === data.form1.garbageId)
    let points = garbage?.points || 0
    data.form1.score = data.form1.num * points
    data.form1.unit = garbage.unit
  }
}

const baseUrl = import.meta.env.VITE_BASE_URL
const handleFileUpload = (res) => {
  data.form.img = res.data
}

const handleFileUpload1 = (res) => {
  data.form1.img = res.data
}

const addRecovery = () => {
  formRef1.value.validate((valid) => {
    if (valid) {
      if (!data.form1.img) {
        ElMessage.warning('请上传可回收垃圾图片')
        return
      }
      data.form1.communityId = data.recoverySite.communityId
      data.form1.siteId = data.recoverySite.id
      request.post('/recoveryRecords/add', data.form1).then(res => {
        if (res.code === '200') {
          ElMessage.success('操作成功')
          data.formVisible1 = false
          load()
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

const handleAdd = () => {
  data.form = {}
  data.formVisible = true
}

const handleAdd1 = () => {
  data.form1 = { num: 1 }
  data.formVisible1 = true
}

const add = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      if (!data.form.img) {
        ElMessage.warning('请上传垃圾照片!')
        return
      }
      data.form.communityId = data.recoverySite.communityId
      data.form.siteId = data.recoverySite.id
      request.post('/garbageLaunch/add', data.form).then(res => {
        if (res.code === '200') {
          ElMessage.success('操作成功')
          data.formVisible = false
          load()
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })
}

request.get('/recycleGarbage/selectAll').then(res => {
  data.recycleGarbageList = res.data
})

const load = () => {
  request.get('/recoverySite/selectById/' + data.id).then(res => {
    data.recoverySite = res.data
  })
}
load()
</script>

<style scoped>

</style>