<template>
  <div class="shopping-cart">
    <h1>购物车</h1>
    <el-table :data="cartItems" style="width: 100%" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="productName" label="商品名称" width="180"></el-table-column>
      <el-table-column prop="productActualPrice" label="单价" width="180">
        <template #default="scope">
          {{ scope.row.productActualPrice }} 元
        </template>
      </el-table-column>
      <el-table-column label="数量" width="180">
        <template #default="scope">
          <el-input-number
              v-model="scope.row.quantity"
              :min="1"
              :max="10"
          ></el-input-number>
        </template>
      </el-table-column>
      <el-table-column label="小计" width="180">
        <template #default="scope">
          {{ scope.row.productActualPrice * scope.row.quantity }} 元
        </template>
      </el-table-column>
      <el-table-column label="操作" width="180">
        <template #default="scope">
          <el-button type="danger" @click="removeItem(scope.row.id)">
            <i class="el-icon-delete"></i>
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="total">
      <span>总价: {{ totalPrice }} 元</span>
    </div>
    <div class="actions">
      <el-button type="primary" @click="handleBuyNow">
        <i class="el-icon-shopping-cart"></i>
        立即购买
      </el-button>
    </div>
  </div>
</template>

<script setup>
import {ref, computed, watch, onBeforeUnmount, nextTick} from 'vue';
import {updateShopCar, getShopCar, removeShopCar} from "@/api/system/car.js";
import {useCartStore} from "@/store/modules/cart.js";
import {addOrder} from "@/api/system/order.js";
import {useRouter} from 'vue-router';

const router = useRouter();
const cartStore = useCartStore();
const cartItems = ref([]);
const selectedItems = ref([]);
const orderForm = ref({
  productDTOList: []
});
const updateCar = ref({
  productId: null,
  num: 0,
});

const totalPrice = computed(() => {
  return selectedItems.value.reduce((total, item) => {
    return total + item.productActualPrice * item.quantity;
  }, 0);
});

/** 初始化购物车信息 */
const initCartItems = () => {
  // 从本地存储中获取购物车信息
  getShopCar().then(response => {
    console.log(response.data)
    cartItems.value = response.data;
  })
};

const handleQuantityChange = (row, newValue, oldValue) => {
  let flag = newValue > oldValue ? 1 : -1;
  updateCar.value.productId = row.id;
  updateCar.value.num = flag;
  updateShopCar(updateCar.value).then(() => {
    // 更新本地状态，避免不必要的 API 调用
    const itemIndex = cartItems.value.findIndex(item => item.id === row.id);
    if (itemIndex !== -1) {
      cartItems.value[itemIndex].quantity = newValue;
    }
    initCartItems();
    cartStore.updateSize();
  })
};

// 监听每个商品对象的变化
watch(
    () => cartItems.value?.map(item => item.quantity),
    (newQuantities, oldQuantities) => {
      newQuantities?.forEach((newQty, index) => {
        const oldQty = oldQuantities?.[index];
        if (oldQty !== undefined && newQty !== oldQty) {
          console.log('商品', cartItems.value[index].id, '旧值:', oldQty, '新值:', newQty);
          handleQuantityChange(cartItems.value[index], newQty, oldQty);
        }
      });
    },
    {deep: true}
);

/** 删除商品信息 */
const removeItem = (id) => {
  removeShopCar(id).then(response => {
    initCartItems();
    cartStore.updateSize();
  })
};

const handleSelectionChange = (selection) => {
  selectedItems.value = selection;
};

const handleBuyNow = () => {
  if (selectedItems.value.length === 0) {
    alert('请选择要购买的商品');
    return;
  }
  // 处理立即购买逻辑
  console.log('购买的商品:', selectedItems.value);

  let orderId = 0;
  orderForm.value.productDTOList = selectedItems.value.map(item => ({
    productId: item.id,
    quantity: item.quantity
  }));
  console.log(orderForm.value.productDTOList)
  addOrder(orderForm.value).then(response => {
    if (response.code === 200) {
      orderId = response.data

      // 删除已购买的商品
      const removalPromises = orderForm.value.productDTOList.map(item => {
        return removeItem(item.productId);
      });

      // 等待所有删除操作完成
      Promise.all(removalPromises).then(() => {
        // 跳转订单页面
        router.push({
          path: '/order-new',
          query: {
            orderId: orderId
          }
        });
      })
    }
  })

};

// 使用 nextTick 确保在页面渲染完成后初始化数据
nextTick(() => {
  initCartItems();
});
</script>

<style scoped lang="scss">
.shopping-cart {
  padding: 20px;
  background: #f5f7fa;
  min-height: 100vh;
}

h1 {
  text-align: center;
  margin-bottom: 20px;
  font-size: 24px;
  color: #333;
}

.el-table {
  margin-bottom: 20px;
  border: 1px solid #ebeef5;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
}

.el-table::before {
  height: 0;
}

.el-table__header-wrapper th {
  background-color: #f5f7fa;
  color: #333;
}

.el-table__body-wrapper td {
  padding: 12px;
}

.total {
  margin-top: 20px;
  text-align: center;
  font-size: 18px;
  font-weight: bold;
  padding: 10px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
}

.actions {
  text-align: center;
  margin-top: 20px;
}

.el-button {
  margin: 10px;
  padding: 10px 20px;
  font-size: 16px;
}

.el-button--primary {
  background-color: #409eff;
  border-color: #409eff;
  color: #fff;
}

.el-button--danger {
  background-color: #f56c6c;
  border-color: #f56c6c;
  color: #fff;
}

.el-input-number {
  width: 100%;
}

.el-icon-delete,
.el-icon-shopping-cart {
  margin-right: 5px;
}
</style>