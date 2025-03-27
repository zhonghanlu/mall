<template>
  <Layout>
    <div class="common-layout">
      <el-container>
        <el-main>
          <el-card class="product-detail-card">
            <template #header>
              <div class="card-header">
                <span>{{ product.productName }}</span>
              </div>
            </template>
            <div class="product-gallery">
              <el-carousel :interval="4000" type="card" height="400px">
                <el-carousel-item v-for="image in product.images" :key="image">
                  <image-preview :src="image"/>
                </el-carousel-item>
              </el-carousel>
            </div>
            <div class="product-info">
              <p>商品价格: {{ product.productPrice }} 元</p>
              <p>惠后价格: {{ product.productActualPrice }} 元</p>
              <p>库存: {{ product.productInventory }} 件</p>
              <div class="tag-label-category">
                <el-tag type="primary">{{ product.categoryName }}</el-tag>
                <el-tag
                    v-for="item in product.shopLabelList"
                    :key="item.id"
                    type="warning"
                    effect="plain"
                    round
                >
                  {{ item.labelName }}
                </el-tag>
              </div>
              <div>
                数量：
                <el-input-number v-model="num" :min="1" :max="product.productInventory" @change="numberChange"/>
              </div>
              <div class="button-group">
                <el-button type="success" @click="addToCar(product)">加入购物车</el-button>
                <el-button type="danger" @click="buyNow(product.id)">立即购买</el-button>
              </div>
            </div>
            <div class="product-description">
              <h3>商品描述</h3>
              <div v-html="product.productIntro"></div>
            </div>
          </el-card>
        </el-main>
      </el-container>
    </div>
  </Layout>
</template>

<script setup>
import {ref, computed} from 'vue';
import {getProduct, listProduct} from "@/api/system/product.js";
import ImagePreview from "@/components/ImagePreview/index.vue";
import {updateShopCar, getShopCarSize} from "@/api/system/car.js";
import {useRoute} from "vue-router";
import {addOrder} from "@/api/system/order.js";
import Layout from "@/components/Layout.vue";
import {useCartStore} from "@/store/modules/cart.js";

const {proxy} = getCurrentInstance();
const router = useRouter();
const route = useRoute();
const num = ref(1)
const cartStore = useCartStore();
const product = ref({
  id: 0,
  productName: '',
  productPrice: 0,
  productActualPrice: 0,
  productInventory: 1,
  categoryName: '',
  shopLabelList: [],
  fileUrl: '',
  productIntro: '',
  images: [] // 新增图片数组
});

// 创建订单
const orderForm = ref({
  "productDTOList": [
    {
      productId: 0,
      quantity: 0
    }
  ]
})

const productList = ref([]);

const carSize = ref(0);
const addCar = ref({
  productId: null,
  quantity: null,
})

/** 数量改变 */
const numberChange = () => {
  if (num.value > product.value.productInventory) {
    num.value -= 1
  }
}

/** 添加购物车 */
const addToCar = (product) => {
  addCar.value.productId = product.id;
  addCar.value.num = 1
  updateShopCar(addCar.value).then((response) => {
    if (response.code === 200) {
      // 添加成功
      proxy.$modal.msgSuccess("添加成功");
      console.log('添加成功');
    } else {
      // 添加失败
      proxy.$modal.msgError("添加失败");
      console.log('添加失败');
    }
  }).finally(() => {
    // 回调购物车数量
    cartStore.updateSize();
  })
};

// 立即购买
const buyNow = (id) => {
  let orderId = 0;
  orderForm.value.productDTOList[0].productId = id
  orderForm.value.productDTOList[0].quantity = num.value
  console.log(orderForm.value.productDTOList)
  addOrder(orderForm.value).then(response => {
    if (response.code === 200) {
      orderId = response.data
      // 跳转订单页面
      router.push({
        path: '/order-new',
        query: {
          orderId: orderId
        }
      })
    }
  })
}

// 详情页面数据渲染
const handlerDetail = () => {
  const productId = route.query.productId;
  getProduct(productId).then(response => {
    product.value = response.data;
    product.value.images = [response.data.fileUrl]; // 假设 fileUrl 是主图，可以扩展为数组
  });
}

/** 初始化数据 */
handlerDetail();
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

.product-detail-card {
  margin: 60px auto;
  width: 80%;
  max-width: 1200px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s, box-shadow 0.2s;
}

.product-detail-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.product-gallery {
  margin-bottom: 20px;
  padding: 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
}

.product-info {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  margin-bottom: 20px;

  p {
    margin: 10px 0;
  }

  .el-button {
    margin-top: 10px;
    border-radius: 10px;
    transition: background-color 0.3s, color 0.3s;

    &:hover {
      background-color: #f0f9eb;
      color: #67c23a;
    }
  }

  .tag-label-category {
    margin: 10px;
  }

  .el-tag {
    margin-left: 10px;
  }

  .button-group {
    display: flex;
    gap: 10px; // 增加按钮间距
    margin-top: 20px; // 增加按钮组顶部间距
  }
}

.product-description {
  h3 {
    margin-bottom: 10px;
  }
}
</style>
