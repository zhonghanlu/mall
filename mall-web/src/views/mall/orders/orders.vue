<template>
  <div class="orders">
    <h2>我的订单</h2>
    <el-table :data="orders" style="width: 100%">
      <el-table-column prop="id" label="订单号" width="180"></el-table-column>
      <el-table-column prop="orderTime" label="日期" width="180"></el-table-column>
      <el-table-column prop="productTotalPrice" label="商品总价" width="180"></el-table-column>
      <el-table-column prop="orderTotalPrice" label="实际付款" width="180"></el-table-column>
      <el-table-column label="状态">
        <template #default="scope">
          <el-tag>{{
              scope.row.orderStatus === 0 ? '待付款' : scope.row.orderStatus === 1 ? '待发货' : scope.row.orderStatus === 2 ? '已退款' : scope.row.orderStatus === 3 ? '已发货' : scope.row.orderStatus === 4 ? '已签收' : ''
            }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="详情" width="180">
        <template #default="scope">
          <div v-if="scope.row.orderStatus === 0">
            <el-button>
              <router-link :to="'/order-new?orderId='+scope.row.id">去付款</router-link>
            </el-button>
          </div>
          <div>
            <el-button @click="openOrderStatus(scope.row.id)">
              查看配送状态
            </el-button>
          </div>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog title="订单实时状态" v-model="open" width="500px" append-to-body>
      <div style="height: 300px; max-width: 600px">
        <!-- 修改: 将方向改为 horizontal，并使用 simple 样式 -->
        <el-steps :active="orderStatus" direction="vertical" finish-status="success">
          <el-step title="待付款" description="等待用户实际付款"/>
          <el-step title="待发货" description="等待商家进行确认订单发货"/>
          <el-step title="已发货" description="商家已经发货等待骑手接单"/>
          <el-step title="已送达" description="订单已经通过骑手送达目的地"/>
        </el-steps>
      </div>
    </el-dialog>

  </div>
</template>

<script setup>
import {ref} from 'vue';
import {getOrder, orderListSelf} from "@/api/system/order.js";

const orders = ref([]);
const open = ref(false);
const orderStatus = ref(0)

const openOrderStatus = (id) => {
  open.value = true
  getOrder(id).then(response => {
    orderStatus.value = response.data.orderStatus + 1
  })
}

const getOrders = () => {
  // 获取订单列表
  orderListSelf().then(response => {
    // console.log(response);
    orders.value = response.rows;
  }).catch(() => {
    proxy.$modal.msgError("获取订单列表失败");
  });
};

getOrders();
</script>

<style scoped lang="scss">
.orders {
  padding: 20px;
}

// 添加自定义样式以增强视觉效果
.el-steps {
  margin-top: 20px;
}

.el-step__title {
  font-size: 14px;
  color: #333;
}

.el-step__description {
  font-size: 12px;
  color: #999;
}
</style>