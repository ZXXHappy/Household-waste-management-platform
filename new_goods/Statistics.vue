<template>
  <div>
    <el-row :gutter="10">
     <el-col :span="6">
       <div class="card" style="padding: 20px; display: flex; align-items: center">
         <div style="flex: 1; text-align: center">
           <img src="@/assets/imgs/1.png" alt="" style="width: 80px; height: 80px">
         </div>
         <div style="flex: 1; font-size: 20px;">
           <div style="margin-bottom: 15px">垃圾投放记录</div>
           <div style="font-weight: bold">{{ data.count.launch }}</div>
         </div>
       </div>
     </el-col>
      <el-col :span="6">
        <div class="card" style="padding: 20px; display: flex; align-items: center">
          <div style="flex: 1; text-align: center">
            <img src="@/assets/imgs/2.png" alt="" style="width: 80px; height: 80px">
          </div>
          <div style="flex: 1; font-size: 20px;">
            <div style="margin-bottom: 15px">垃圾回收记录</div>
            <div style="font-weight: bold">{{ data.count.recovery }}</div>
          </div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="card" style="padding: 20px; display: flex; align-items: center">
          <div style="flex: 1; text-align: center">
            <img src="@/assets/imgs/3.png" alt="" style="width: 80px; height: 80px">
          </div>
          <div style="flex: 1; font-size: 20px;">
            <div style="margin-bottom: 15px">积分兑换记录</div>
            <div style="font-weight: bold">{{ data.count.score }}</div>
          </div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="card" style="padding: 20px; display: flex; align-items: center">
          <div style="flex: 1; text-align: center">
            <img src="@/assets/imgs/4.png" alt="" style="width: 80px; height: 80px">
          </div>
          <div style="flex: 1; font-size: 20px;">
            <div style="margin-bottom: 15px">垃圾投放/回收点</div>
            <div style="font-weight: bold">{{ data.count.site }}</div>
          </div>
        </div>
      </el-col>
    </el-row>

    <div style="margin: 10px 0">
      <el-row :gutter="10">
       <el-col :span="12">
         <div class="card" style="padding: 20px">
           <div id="line" style="height: 500px"></div>
         </div>
       </el-col>
        <el-col :span="12">
          <div class="card" style="padding: 20px">
            <div id="pie" style="height: 500px"></div>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { reactive, onMounted } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import * as echarts from 'echarts'

const lineOption = {
  title: {
    text: '近一周垃圾回收记录的趋势图',
    left: 'center'
  },
  tooltip: {
    trigger: 'axis'
  },
  legend: {
    left: 'left'
  },
  xAxis: {
    type: 'category',
    data: []
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      data: [],
      type: 'line',
      smooth: true,
      markPoint: {
        data: [
          { type: 'max', name: 'Max' },
          { type: 'min', name: 'Min' }
        ]
      },
      markLine: {
        data: [{ type: 'average', name: 'Avg' }]
      }
    },
  ]
}

const pieOption = {
  title: {
    text: '不同类型的垃圾投放记录统计',
    subtext: '比例图',
    left: 'center'
  },
  tooltip: {
    trigger: 'item'
  },
  legend: {
    orient: 'vertical',
    left: 'left'
  },
  series: [
    {
      type: 'pie',
      center: ['50%', '60%'],
      radius: '50%',
      data: [],
      label: {
        show: true,
        formatter(param) {
          return param.name + ' (' + param.percent + '%)';
        }
      },
      emphasis: {
        itemStyle: {
          shadowBlur: 10,
          shadowOffsetX: 0,
          shadowColor: 'rgba(0, 0, 0, 0.5)'
        }
      }
    }
  ]
}

const data = reactive({
  count: {}
})

request.get('/count').then(res => {
  data.count = res.data
})

// 等页面元素加载好之后再初始化图表
onMounted(() => {
// 折线图
  let lineDom = document.getElementById('line');
  let lineChart = echarts.init(lineDom);

  request.get('/line').then(res => {
    lineOption.xAxis.data = res.data.x
    lineOption.series[0].data = res.data.y
    lineChart.setOption(lineOption)
  })

  // 饼图
  let pieDom = document.getElementById('pie');
  let pieChart = echarts.init(pieDom);
  request.get('/pie').then(res => {
    pieOption.series[0].data = res.data
    pieChart.setOption(pieOption)
  })

})

</script>

<style scoped>

</style>