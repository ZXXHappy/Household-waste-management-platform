<template>
  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.name" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入回收点名称查询"></el-input>
      <el-button type="info" plain @click="load">查询</el-button>
      <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
      <el-button type="primary" plain @click="handleAdd" v-if="data.user.role === 'COMMUNITY'">新增</el-button>
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" />
        <el-table-column prop="communityName" label="社区名称"></el-table-column>
        <el-table-column prop="name" label="投放点名称"></el-table-column>
        <el-table-column prop="img" label="投放点照片">
          <template #default="scope">
            <el-image style="width: 80px; height: 50px; border-radius: 5px" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="timeRange" label="开放时间"></el-table-column>
        <el-table-column prop="managerName" label="管理员名称"></el-table-column>
        <el-table-column prop="managerPhone" label="管理员电话"></el-table-column>
        <el-table-column prop="status" label="回收点状态">
          <template v-slot="scope">
            <el-tag type="success" v-if="scope.row.status === '运行中'">运行中</el-tag>
            <el-tag type="danger" v-if="scope.row.status === '已关闭'">已关闭</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="content" label="详情">
          <template #default="scope">
            <el-button type="primary" @click="view(scope.row.content)">查看内容</el-button>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="100" fixed="right">
          <template v-slot="scope">
            <el-button type="primary" circle :icon="Edit" @click="handleEdit(scope.row)" v-if="data.user.role === 'COMMUNITY'"></el-button>
            <el-button type="danger" circle :icon="Delete" @click="del(scope.row.id)"></el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
    </div>

    <el-dialog title="回收点信息" v-model="data.formVisible" width="50%" destroy-on-close>
      <el-form ref="formRef" :model="data.form" :rules="data.rules" label-width="100px" style="padding: 20px">
        <el-form-item prop="communityId" label="社区">
          <el-select style="width: 100%" v-model="data.form.communityId">
            <el-option v-for="item in data.communityList" :key="item.id" :value="item.id" :label="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="name" label="投放点名称">
          <el-input v-model="data.form.name" placeholder="请输入投放点名称"></el-input>
        </el-form-item>
        <el-form-item prop="img" label="投放点照片">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload"
              list-type="picture"
          >
            <el-button type="primary">上传</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="timeRange" label="开放时间">
          <div style="width: 100%; display: flex; align-items: center; grid-gap: 10px">
            <el-time-select
                v-model="data.open"
                style="flex: 1"
                start="08:00"
                step="00:30"
                end="20:30"
                placeholder="选择开始时间"
            />
            <el-time-select
                v-model="data.close"
                style="flex: 1"
                start="08:30"
                step="00:30"
                end="21:00"
                placeholder="选择结束时间"
            />
          </div>
        </el-form-item>
        <el-form-item prop="status" label="回收点状态">
          <el-radio-group v-model="data.form.status">
            <el-radio-button label="运行中" value="运行中"></el-radio-button>
            <el-radio-button label="已关闭" value="已关闭"></el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item prop="content" label="详情">
          <div style="border: 1px solid #ccc; width: 100%">
            <Toolbar
                style="border-bottom: 1px solid #ccc"
                :editor="editorRef"
                :mode="mode"
            />
            <Editor
                style="height: 500px; overflow-y: hidden;"
                v-model="data.form.content"
                :mode="mode"
                :defaultConfig="editorConfig"
                @onCreated="handleCreated"
            />
          </div>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="save">确 定</el-button>
        </span>
      </template>
    </el-dialog>


    <el-dialog title="内容" v-model="data.viewVisible" width="50%" :close-on-click-modal="false" destroy-on-close>
      <div class="editor-content-view" style="padding: 20px" v-html="data.content"></div>
      <template #footer>
    <span class="dialog-footer">
      <el-button @click="data.viewVisible = false">关 闭</el-button>
    </span>
      </template>
    </el-dialog>

  </div>
</template>

<script setup>

</script>