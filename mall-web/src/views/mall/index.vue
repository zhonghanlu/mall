<template>
  <Layout>
    <div class="common-layout">
      <el-container>
        <el-aside width="200px" class="fixed-aside">
          <div class="tag-category">
            <p>分类</p>
            <div class="button-container">
              <el-button
                  v-for="item in checkTag.categoryList"
                  :key="item.id"
                  :type="checkTag.categorySelect.includes(item.id) ? 'primary' : 'default'"
                  @click="toggleCategory(item.id)"
                  class="category-button"
                  plain
                  size="small"
              >
                {{ item.categoryName }}
              </el-button>
            </div>
          </div>

          <div class="tag-label">
            <p>标签</p>
            <div class="button-container">
              <el-button
                  v-for="item in checkTag.labelList"
                  :key="item.id"
                  :type="checkTag.labelSelect.includes(item.id) ? 'primary' : 'default'"
                  @click="toggleLabel(item.id)"
                  class="label-button"
                  plain
                  size="small"
              >
                {{ item.labelName }}
              </el-button>
            </div>
          </div>
        </el-aside>

        <el-main>
          <!-- 轮播 -->
          <div class="carousel-container">
            <el-carousel :interval="3000" type="card" height="200px">
              <el-carousel-item v-for="item in bannerList" :key="item">
                <el-image :src="item.url" fit="cover" style="width: 100%; height: 100%"/>
              </el-carousel-item>
            </el-carousel>
          </div>

          <div class="product-list">
            <el-card
                v-for="product in productList"
                :key="product.id"
                class="box-card"
            >
              <template #header>
                <div class="card-header">
                  <span>{{ product.productName }}</span>
                </div>
              </template>
              <div class="img-viewer">
                <image-preview :src="product.fileUrl" :width="250" :height="120"/>
              </div>
              <div @click="handlerToDetail(product.id)">
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
                </div>
              </div>
              <el-button type="primary" class="add-to-cart" @click="addToCar(product)">加入购物车</el-button>
            </el-card>
          </div>
          <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
                      v-model:limit="queryParams.pageSize" @pagination="handleSearch"/>
        </el-main>
      </el-container>
    </div>
  </Layout>
</template>

<script setup>
import {ref, computed, onMounted, getCurrentInstance} from 'vue';
import {listProduct} from "@/api/system/product.js";
import ImagePreview from "@/components/ImagePreview/index.vue";
import {listAllCategory} from "@/api/system/category.js";
import {listAllLabel} from "@/api/system/label.js";
import {updateShopCar, getShopCarSize} from "@/api/system/car.js";
import {useCartStore} from '@/store/modules/cart.js';
import Layout from "@/components/Layout.vue";
import eventBus from "@/utils/eventBus.js"; // 引入 eventBus

const {proxy} = getCurrentInstance();
const router = useRouter();

const cartStore = useCartStore();

const checkTag = ref({
  categoryList: [],
  labelList: [],
  categorySelect: [], // 修改为数组，但只允许一个元素
  labelSelect: [],
});
const total = ref(0);
const bannerList = ref([
  {url: 'src/assets/banner/banner1.png'},
  {url: 'src/assets/banner/banner2.png'},
  {url: 'src/assets/banner/banner3.png'},
  {url: 'src/assets/banner/banner4.png'},
  {url: 'src/assets/banner/banner5.png'},
  {url: 'src/assets/banner/banner6.png'},
]);

const queryParams = ref({
  pageSize: 10,
  pageNum: 1,
  productName: null,
  categoryId: null,
  labelIdList: null,
  labelName: null,
  productPrice: null,
  productActualPrice: null,
  productStatus: 1,
  productInventory: null,
  productIntro: null,
});

const productList = ref([]);

const addCar = ref({
  productId: null,
  num: 0,
});

/** 查询分类列表 */
function getCategoryList() {
  listAllCategory().then(response => {
    checkTag.value.categoryList = response.data;
  });
}

/** 查询商品标签列表 */
function getLabelList() {
  listAllLabel().then(response => {
    checkTag.value.labelList = response.data;
  });
}

/** 查询商品列表 */
const handleSearch = () => {
  // 处理搜索逻辑
  listProduct(queryParams.value).then(response => {
    productList.value = response.rows;
    total.value = response.total;
  });
};

const toggleCategory = (id) => {
  if (checkTag.value.categorySelect.includes(id)) {
    checkTag.value.categorySelect = []; // 清空选择
  } else {
    checkTag.value.categorySelect = [id]; // 设置为单选
  }
  queryParams.value.categoryId = checkTag.value.categorySelect[0] || null;
  handleSearch();
};

const toggleLabel = (id) => {
  if (checkTag.value.labelSelect.includes(id)) {
    checkTag.value.labelSelect.splice(checkTag.value.labelSelect.indexOf(id), 1);
  } else {
    checkTag.value.labelSelect.push(id);
  }
  queryParams.value.labelIdList = checkTag.value.labelSelect;
  handleSearch();
};

const addToCar = (product) => {
  addCar.value.productId = product.id;
  addCar.value.num = 1;
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
  });
};

// 跳转到商品详情
const handlerToDetail = (id) => {
  router.push({
    path: '/product-detail',
    query: {
      productId: id,
    },
  });
};

onMounted(() => {
  // 监听来自 Header.vue 的搜索事件
  eventBus.on('triggerSearch', (searchQuery) => {
    queryParams.value.productName = searchQuery;
    handleSearch();
  });
});

/** 初始化数据 */
handleSearch();
getCategoryList();
getLabelList();
cartStore.updateSize();
</script>

<style scoped lang="scss">
.common-layout {
  padding-top: 60px;
}

.fixed-aside {
  position: fixed;
  top: 60px;
  bottom: 0;
  background-color: #fff;
  padding: 20px;
  z-index: 999;
  border-right: 1px solid #ebeef5;
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.tag-category, .tag-label {
  p {
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
    font-size: 16px;
  }

  .button-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
    gap: 10px;
    width: 100%;
  }
}

.category-button, .label-button {
  margin: 0 !important;
  width: 100%;
  min-width: 100px;
  text-align: center;
  border-radius: 16px !important;
  transition: all 0.3s ease;
  padding: 8px 12px;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  }
}

.el-main {
  margin-left: 220px;
  padding: 30px;
}

.carousel-container {
  margin-bottom: 40px;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.product-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 30px;
  padding: 20px 0;
}

.box-card {
  transition: transform 0.3s ease;
  border: none;

  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
  }

  :deep(.el-card__header) {
    padding: 15px 20px;
    background-color: #f8f9fa;
  }
}

.add-to-cart {
  width: 100%;
  margin-top: 15px;
  border-radius: 20px;
  padding: 12px;
}

.tag-label-category {
  margin-top: 15px;
  display: flex;
  flex-wrap: wrap;
  gap: 8px;

  .el-tag {
    margin: 0;
  }
}

.product-info {
  p {
    margin: 8px 0;
    font-size: 13px;
    color: #666;
  }
}

.img-viewer {
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 15px;
}
</style>