<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="订单号" prop="orderId">
        <el-input
            v-model="queryParams.orderId"
            placeholder="请输入关联订单id"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
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
      <el-table-column label="物流状态" align="center" prop="logisticsStatus">
        <template #default="scope">
          <el-tag>{{
              scope.row.logisticsStatus === 0 ? '待接单' :
                  scope.row.logisticsStatus === 1 ? '已接单' :
                      scope.row.logisticsStatus === 2 ? '送货中' :
                          scope.row.logisticsStatus === 3 ? '已送达' : ''
            }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="配送时间" align="center" prop="logisticsTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.logisticsTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="配送价格" align="center" prop="logisticsPrice"/>
      <el-table-column label="配送地址" align="center" prop="logisticsAddress"
                       width="240"
                       show-overflow-tooltip/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="takeOrder(scope.row)"
                     v-hasPermi="['system:logistics:edit']"
                     v-if="scope.row.logisticsStatus === 0">接单
          </el-button>
          <el-button link type="primary" icon="Search" @click="deliveryOrder(scope.row)"
                     v-hasPermi="['system:logistics:edit']"
                     v-if="scope.row.logisticsStatus !== 0">送货
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
        <el-form-item label="关联订单id" prop="orderId">
          <el-input v-model="form.orderId" placeholder="请输入关联订单id"/>
        </el-form-item>
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
        <el-form-item label="删除标识" prop="delFlag">
          <el-input v-model="form.delFlag" placeholder="请输入删除标识"/>
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
import {
  listLogistics,
  getLogistics,
  delLogistics,
  addLogistics,
  updateLogistics,
  takeOrderLogistics
} from "@/api/system/logistics.js";
import {parseTime} from "../../../utils/ruoyi.js";
import {useRouter} from "vue-router";

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
const router = useRouter();

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
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

/** 接单操作 */
function takeOrder(row) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('是否确认接物流信息编号为"' + _ids + '"的订单？').then(function () {
    return takeOrderLogistics(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("接单");
  }).catch(() => {
  });
}

/** 送货操作 */
function deliveryOrder(row) {
  console.log("push 前" + row.orderId, row.logisticsAddress); // 确认这两个值不为空
  router.push({
    path: "/delivery/map"
    ,
    query: {
      id: row.id,
      logisticsAddress: row.logisticsAddress,
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
