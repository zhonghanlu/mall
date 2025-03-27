<template>
  <Layout>
    <div class="common-layout">
      <el-container>
        <el-main>
          <el-card class="order-form-card">
            <template #header>
              <div class="card-header">
                <span>创建订单</span>
              </div>
            </template>
            <el-form :model="orderForm" :rules="rules" ref="orderFormRef" label-width="120px">
              <el-form-item label="收货人姓名" prop="placeOrderName">
                <el-input v-model="orderForm.placeOrderName"></el-input>
              </el-form-item>
              <el-form-item label="收货人电话" prop="orderPhone">
                <el-input v-model="orderForm.orderPhone"></el-input>
              </el-form-item>
              <el-form-item label="收货地址" prop="orderAddress">
                <el-input v-model="orderForm.orderAddress"></el-input>
              </el-form-item>
              <el-form-item label="配送方式" prop="deliveryMethod">
                <el-select v-model="orderForm.deliveryMethod" placeholder="请选择配送方式">
                  <el-option label="快递" value="express"></el-option>
                  <el-option label="自提-暂不支持" disabled value="pickup"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="支付方式" prop="paymentMethod">
                <el-select v-model="orderForm.paymentMethod" placeholder="请选择支付方式">
                  <el-option label="支付宝" value="alipay"></el-option>
                  <el-option label="微信支付-暂不支持" disabled value="wechat"></el-option>
                  <el-option label="银行卡-暂不支持" disabled value="bank"></el-option>
                </el-select>
              </el-form-item>
            </el-form>

            <el-card class="product-list-card">
              <template #header>
                <div class="card-header">
                  <span>商品清单</span>
                </div>
              </template>
              <el-table :data="productList" style="width: 100%">
                <el-table-column prop="productName" label="商品名称" width="180"></el-table-column>
                <el-table-column prop="productActualPrice" label="单价" width="180"></el-table-column>
                <el-table-column prop="quantity" label="数量" width="180"></el-table-column>
                <el-table-column label="总价">
                  <template #default="scope">
                    {{ scope.row.productActualPrice * scope.row.quantity }} 元
                  </template>
                </el-table-column>
              </el-table>
              <div class="total-price">
                <p>商品总价: {{ totalPrice }} 元</p>
                <p>运费: {{ deliveryFee }} 元</p>
                <p>订单总价: {{ orderTotalPrice }} 元</p>
              </div>
            </el-card>

            <el-button type="primary" @click="submitOrder">提交订单</el-button>
          </el-card>
        </el-main>
      </el-container>
    </div>
  </Layout>
</template>

<script setup>
import {ref, computed} from 'vue';
import {useRouter} from 'vue-router';
import {getShopCarSize} from "@/api/system/car.js";
import {listProduct} from "@/api/system/product.js";
import {getOrder, updateOrder} from "@/api/system/order.js";
import {aliPay} from "@/api/system/aliPay.js";
import Layout from "@/components/Layout.vue";

const queryParams = ref({
  pageSize: 10,
  productName: null,
  categoryId: null,
  labelIdList: null,
  labelName: null,
  productPrice: null,
  productActualPrice: null,
  productStatus: null,
  productInventory: null,
  productIntro: null,
});

const route = useRoute();
const router = useRouter();
const orderFormRef = ref(null);
const orderForm = ref({
  id: 0,
  placeOrderName: '',
  orderPhone: '',
  orderAddress: '',
  deliveryMethod: 'express',
  paymentMethod: 'alipay'
});

const productList = ref(null);

const rules = ref({
  placeOrderName: [{required: true, message: '请输入收货人姓名', trigger: 'blur'}],
  orderPhone: [{required: true, message: '请输入收货人电话', trigger: 'blur'}],
  orderAddress: [{required: true, message: '请输入收货地址', trigger: 'blur'}],
  deliveryMethod: [{required: true, message: '请选择配送方式', trigger: 'change'}],
  paymentMethod: [{required: true, message: '请选择支付方式', trigger: 'change'}]
});

const totalPrice = computed(() => {
  if (productList.value !== null) {
    return productList.value.reduce((sum, product) => sum + (product.productActualPrice * product.quantity), 0);
  }
});

const deliveryFee = computed(() => {
  return orderForm.value.deliveryMethod === 'express' ? 10 : 0;
});

const orderTotalPrice = computed(() => {
  return totalPrice.value + deliveryFee.value;
});

/** 获取订单数据 */
const getOrderById = () => {
  getOrder(route.query.orderId).then(response => {
    console.log(response.data)
    // 支付成功
    if (response.data.orderStatus !== 0) {
      router.push({
        path: '/mall',
      })
    }
    orderForm.value = response.data;
    productList.value = response.data.shopSkuSpuProductVoList
  });
}

/** 提交订单 拉取支付*/
const submitOrder = () => {
  // 更新订单数据
  updateOrder(orderForm.value).then(response => {
    console.log(orderForm.value)
  }).catch(() => {
    proxy.$modal.msgError("更新订单失败");
  })
  window.open(import.meta.env.VITE_APP_BASE_API + '/alipay/pay?orderId=' + orderForm.value.id)
}

/** 初始化数据 */
getOrderById();
</script>

<style scoped lang="scss">
.common-layout {
  padding-top: 0px;
}

.el-header {
  padding: 10px 20px;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1000;
  display: flex;
  justify-content: center;
  align-items: center;
}

.header-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  max-width: 1400px;
  margin: 0 auto;
}

.logo img {
  height: 30px;
}

.search-box {
  display: flex;
  align-items: center;
  border: 1px solid #2d6ce1;
  border-radius: 20px;
  overflow: hidden;
}

.search-input {
  padding: 10px 20px;
  border: none;
  outline: none;
  width: 100%;
}

.right-section {
  display: flex;
  align-items: center;
}

.right-section .el-button {
  margin-left: 10px;
}

.right-section .el-avatar {
  margin-left: 10px;
}

.order-form-card {
  margin: 60px auto;
  width: 80%;
  max-width: 1200px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.product-list-card {
  margin-top: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.total-price {
  margin-top: 20px;
  text-align: right;
  padding: 10px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
}

.el-button {
  margin-top: 20px;
  width: 100%;
  border-radius: 10px;
}
</style>
