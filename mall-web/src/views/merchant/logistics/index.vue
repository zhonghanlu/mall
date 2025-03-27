<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="物流状态" prop="logisticsStatus">
        <el-select v-model="queryParams.logisticsStatus" placeholder="请选择" clearable style="width: 240px">
          <el-option label="待接单" :value="0"></el-option>
          <el-option label="已接单" :value="1"></el-option>
          <el-option label="送货中" :value="2"></el-option>
          <el-option label="已送达" :value="3"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="Download"
            @click="handleExport"
        >导出
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="logisticsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="主键id" align="center" prop="id"/>
      <el-table-column label="关联订单id" align="center" prop="orderId"/>
      <el-table-column label="物流名称" align="center" prop="logisticsName"/>
      <el-table-column label="配送时间" align="center" prop="logisticsTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.logisticsTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="物流状态" align="center" prop="logisticsStatus">
        <template #default="scope">
          <el-tag>{{
              scope.row.logisticsStatus===0?'待接单':
              scope.row.logisticsStatus===1?'已接单':
              scope.row.logisticsStatus===2?'送货中':
              scope.row.logisticsStatus===3?'已送达':''
            }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="配送价格(元)" align="center" prop="logisticsPrice"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
          >修改
          </el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改物流信息对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="logisticsRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="物流名称" prop="logisticsName">
          <el-input v-model="form.logisticsName" placeholder="请输入物流名称"/>
        </el-form-item>
        <el-form-item label="配送时间" prop="logisticsTime">
          <el-date-picker clearable
                          v-model="form.logisticsTime"
                          type="date"
                          value-format="YYYY-MM-DD"
                          placeholder="请选择配送时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="配送价格" prop="logisticsPrice">
          <el-input v-model="form.logisticsPrice" placeholder="请输入配送价格"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Logistics">
import {listLogistics, getLogistics, delLogistics, addLogistics, updateLogistics} from "@/api/system/logistics.js";
import {parseTime} from "../../../utils/ruoyi.js";

const {proxy} = getCurrentInstance();

const logisticsList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    logisticsStatus: null,
    orderId: null,
    logisticsName: null,
    logisticsTime: null,
    logisticsPrice: null,
  },
  rules: {}
});

const {queryParams, form, rules} = toRefs(data);

/** 查询物流信息列表 */
function getList() {
  loading.value = true;
  listLogistics(queryParams.value).then(response => {
    logisticsList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    orderId: null,
    logisticsName: null,
    logisticsTime: null,
    logisticsPrice: null,
    delFlag: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null
  };
  proxy.resetForm("logisticsRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加物流信息";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row.id || ids.value
  getLogistics(_id).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改物流信息";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["logisticsRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateLogistics(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addLogistics(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除物流信息编号为"' + _ids + '"的数据项？').then(function () {
    return delLogistics(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/logistics/export', {
    ...queryParams.value
  }, `logistics_${new Date().getTime()}.xlsx`)
}

getList();
</script>
