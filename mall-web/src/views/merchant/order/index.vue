<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="90px">
      <el-form-item label="下单人姓名" prop="placeOrderName">
        <el-input
            v-model="queryParams.placeOrderName"
            placeholder="请输入下单人姓名"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="订单状态" prop="orderStatus">
        <el-select v-model="queryParams.orderStatus" placeholder="请选择" clearable style="width: 240px">
          <el-option label="待付款" :value="0"></el-option>
          <el-option label="待发货" :value="1"></el-option>
          <el-option label="已退款" :value="2"></el-option>
          <el-option label="已发货" :value="3"></el-option>
          <el-option label="已送达" :value="4"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="订单时间" prop="orderTime">
        <el-date-picker clearable
                        v-model="dateRange"
                        value-format="YYYY-MM-DD"
                        type="daterange"
                        range-separator="-"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
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

    <el-table v-loading="loading" :data="orderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="主键id" align="center" prop="id"/>
      <el-table-column label="下单人姓名" align="center" prop="placeOrderName"/>
      <el-table-column label="订单状态" align="center" prop="orderStatus">
        <template #default="scope">
          <el-tag>{{
              scope.row.orderStatus === 0 ? '待付款' : scope.row.orderStatus === 1 ? '待发货' : scope.row.orderStatus === 2 ? '已退款' : scope.row.orderStatus === 3 ? '已发货' : scope.row.orderStatus === 4 ? '已签收' : ''
            }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="订单总价(元)" align="center" prop="productTotalPrice"/>
      <el-table-column label="实际支付金额" align="center" prop="orderTotalPrice"/>
      <el-table-column label="第三方支付号" align="center" prop="payNo"/>
      <el-table-column label="支付时间" align="center" prop="payTime"/>
      <el-table-column label="订单地址" align="center" prop="orderAddress"
                       width="240"
                       show-overflow-tooltip/>
      <el-table-column label="订单电话" align="center" prop="orderPhone"/>
      <el-table-column label="订单创建时间" align="center" prop="orderTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.orderTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
          >发货
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

    <!-- 添加或修改订单信息对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="orderRef" :model="form" :rules="rules" disabled label-width="90px">
        <el-form-item label="下单人姓名" prop="placeOrderName">
          <el-input v-model="form.placeOrderName" placeholder="请输入下单人姓名"/>
        </el-form-item>
        <el-form-item label="订单地址" prop="orderAddress">
          <el-input v-model="form.orderAddress" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="订单电话" prop="orderPhone">
          <el-input v-model="form.orderPhone" placeholder="请输入订单电话"/>
        </el-form-item>
        <el-form-item label="订单时间" prop="orderTime">
          <el-date-picker clearable
                          v-model="form.orderTime"
                          type="date"
                          value-format="YYYY-MM-DD"
                          placeholder="请选择订单时间">
          </el-date-picker>
        </el-form-item>

        <el-form-item label="订单状态" prop="orderStatus">
          <el-select v-model="form.orderStatus" placeholder="请选择" clearable style="width: 240px">
            <el-option label="待付款" :value="0"></el-option>
            <el-option label="待发货" :value="1"></el-option>
            <el-option label="已退款" :value="2"></el-option>
            <el-option label="已发货" :value="3"></el-option>
            <el-option label="已送达" :value="4"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="订单信息">
          <el-card style="width: 340px">
            <template #header>
              <div class="card-header">
                <span>商品信息</span>
              </div>
            </template>
            <p v-for="item in form.shopSkuSpuProductVoList" :key="item.id" class="text item">
              {{ item.productName + ' X ' + item.quantity + ' : ￥ ' + item.productActualPrice }}</p>
            <template #footer>总价：{{ form.productTotalPrice }}</template>
          </el-card>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="handleSend" v-if="form.orderStatus === 1">发 货</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Order">
import {listOrder, getOrder, delOrder, addOrder, updateOrder, sendOrder} from "@/api/system/order.js";
import {parseTime} from "../../../utils/ruoyi.js";

const {proxy} = getCurrentInstance();

const orderList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const dateRange = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    placeOrderName: null,
    orderStatus: null,
  },
  rules: {}
});

const {queryParams, form, rules} = toRefs(data);

/** 查询订单信息列表 */
function getList() {
  loading.value = true;
  listOrder(proxy.addDateRange(queryParams.value, dateRange.value)).then(response => {
    orderList.value = response.rows;
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
    placeOrderName: null,
    orderStatus: null,
    orderAddress: null,
    orderPhone: null,
    orderTime: null,
    orderTotalPrice: null,
    delFlag: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null
  };
  proxy.resetForm("orderRef");
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
  title.value = "添加订单信息";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row.id || ids.value
  getOrder(_id).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "订单发货信息";
  });
}

/** 发货按钮操作 */
function handleSend() {
  if (form.value.id != null) {
    sendOrder(form.value.id).then(response => {
      proxy.$modal.msgSuccess("发货成功");
      open.value = false;
      getList();
    });
  }
}


/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除订单信息编号为"' + _ids + '"的数据项？').then(function () {
    return delOrder(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/order/export', {
    ...queryParams.value
  }, `order_${new Date().getTime()}.xlsx`)
}

getList();
</script>
