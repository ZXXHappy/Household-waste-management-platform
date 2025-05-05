<template>
  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.title" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入宣传标题查询"></el-input>
      <el-button type="info" plain @click="load">查询</el-button>
      <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
      <el-button type="primary" plain @click="handleAdd">新增</el-button>
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table tooltip-effect="dark myTooltip" stripe :data="data.tableData" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" />
        <el-table-column prop="typeName" label="分类"></el-table-column>
        <el-table-column prop="title" label="标题" show-overflow-tooltip></el-table-column>
        <el-table-column prop="descr" label="简介" show-overflow-tooltip></el-table-column>
        <el-table-column prop="img" label="封面">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px; border-radius: 5px" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="thumbnail1" label="小图1">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px; border-radius: 5px" :src="scope.row.thumbnail1" :preview-src-list="[scope.row.thumbnail1]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="thumbnail2" label="小图2">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px; border-radius: 5px" :src="scope.row.thumbnail2" :preview-src-list="[scope.row.thumbnail2]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="thumbnail3" label="小图3">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px; border-radius: 5px" :src="scope.row.thumbnail3" :preview-src-list="[scope.row.thumbnail3]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="content" label="主体内容">
          <template #default="scope">
            <el-button type="primary" @click="view(scope.row.content)">查看内容</el-button>
          </template>
        </el-table-column>
        <el-table-column prop="viewCount" label="浏览量"></el-table-column>
        <el-table-column label="操作" width="100" fixed="right">
          <template v-slot="scope">
            <el-button type="primary" circle :icon="Edit" @click="handleEdit(scope.row)"></el-button>
            <el-button type="danger" circle :icon="Delete" @click="del(scope.row.id)"></el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="total, prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
    </div>

    <el-dialog title="宣传信息" v-model="data.formVisible" width="50%" destroy-on-close>
      <el-form ref="form" :model="data.form" label-width="70px" style="padding: 20px">
        <el-form-item prop="typeId" label="分类">
          <el-select style="width: 100%" v-model="data.form.typeId">
            <el-option v-for="item in data.typeList" :key="item.id" :value="item.id" :label="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="title" label="标题">
          <el-input v-model="data.form.title" placeholder="请输入标题"></el-input>
        </el-form-item>
        <el-form-item prop="descr" label="简介">
          <el-input type="textarea" :rows="3" v-model="data.form.descr" placeholder="请输入简介"></el-input>
        </el-form-item>
        <el-form-item prop="img" label="封面">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload"
              list-type="picture"
          >
            <el-button type="primary">上传封面</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="thumbnail1" label="小图1">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload1"
              list-type="picture"
          >
            <el-button type="primary">上传小图1</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="thumbnail2" label="小图2">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload2"
              list-type="picture"
          >
            <el-button type="primary">上传小图2</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="thumbnail3" label="小图3">
          <el-upload
              :action="baseUrl + '/files/upload'"
              :headers="{ 'token': data.user.token }"
              :on-success="handleFileUpload3"
              list-type="picture"
          >
            <el-button type="primary">上传小图3</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="content" label="主体内容">
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

<style>
.myTooltip {
  max-width: 40% !important;
}
</style>