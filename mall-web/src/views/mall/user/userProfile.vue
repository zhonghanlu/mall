<template>
  <Layout>
    <div class="user-profile">
      <el-container>
        <!-- 左侧边栏 -->
        <el-aside width="200px" class="side-menu-container">
          <el-menu
              :default-active="activeMenu"
              router
              active-text-color="#409EFF"
              class="side-menu"
          >
            <el-menu-item index="/mall">我的团购</el-menu-item>
            <el-menu-item index="/mall-user/profile">个人信息</el-menu-item>
            <el-menu-item index="/mall-user/car">我的购物车</el-menu-item>
            <el-menu-item index="/mall-user/orders">我的订单</el-menu-item>
            <el-menu-item index="">已买到的宝贝</el-menu-item>
            <el-menu-item index="">我的拍卖</el-menu-item>
            <el-menu-item index="">官方集运</el-menu-item>
            <el-menu-item index="">我的卡券包</el-menu-item>
            <el-menu-item index="">宝贝收藏</el-menu-item>
            <el-menu-item index="">关注店铺</el-menu-item>
            <el-menu-item index="">我的足迹</el-menu-item>
            <el-menu-item index="">购买过的店铺</el-menu-item>
            <el-menu-item index="">我的发票</el-menu-item>
            <el-submenu index="9">
              <template #title>评价管理</template>
              <el-menu-item index="">评价管理</el-menu-item>
              <el-menu-item index="">退款维权</el-menu-item>
            </el-submenu>
            <el-submenu index="10">
              <template #title>账户设置</template>
              <el-menu-item index="">账户设置</el-menu-item>
              <el-menu-item index="">企业工具</el-menu-item>
            </el-submenu>
          </el-menu>
        </el-aside>

        <!-- 主内容区域 -->
        <el-main class="main-content">
          <router-view></router-view> <!-- 动态内容展示区 -->

          <!-- 常买常逛 -->
          <section class="recommend-section">
            <h3 class="section-title">常买常逛</h3>
            <el-row :gutter="20">
              <el-col
                  v-for="(item, index) in items"
                  :key="index"
                  :xs="12" :sm="8" :md="6"
              >
                <el-card
                    class="product-card"
                    shadow="hover"
                    :body-style="{ padding: '0' }"
                >
                  <div class="product-image">
                    <img :src="item.imageUrl" :alt="item.title">
                  </div>
                  <div class="product-info">
                    <p class="product-title">{{ item.title }}</p>
                    <p class="product-price">{{ item.price }}</p>
                  </div>
                </el-card>
              </el-col>
            </el-row>
          </section>
        </el-main>
      </el-container>
    </div>
  </Layout>
</template>

<script setup>
import {computed, ref} from 'vue';
import {useRoute} from "vue-router";
import Layout from "@/components/Layout.vue";

const route = useRoute();

const activeMenu = computed(() => {
  if (route.path === '/mall-user/car') {
    return '/mall-user/car';
  } else if (route.path === '/mall-user/profile') {
    return '/mall-user/profile';
  } else {
    return '/mall-user/profile'; // 默认选中个人信息
  }
});

const items = [
  {
    imageUrl: 'https://placehold.co/200x200',
    title: '001黑金三合一杜蕾斯001首发',
    price: '满600减240'
  },
  {
    imageUrl: 'https://placehold.co/200x200',
    title: '天际38节',
    price: '足金9999 支持开票'
  },
  {
    imageUrl: 'https://placehold.co/200x200',
    title: '领丰金 9999黄金豆豆纯金金豆',
    price: '688.8'
  },
  {
    imageUrl: 'https://placehold.co/200x200',
    title: '飞天53%vol 500ml贵州茅台酒',
    price: '1199'
  },
  {
    imageUrl: 'https://placehold.co/200x200',
    title: '不走食集 岩烧芝士咖啡薄脆饼干',
    price: '12.8'
  }
];
</script>

<style scoped lang="scss">
.user-profile {
  background: #f5f7fa;
  min-height: 100vh;
  width: 100%;
  max-width: 1400px;
  margin: 30px auto;
}

.side-menu-container {
  background-color: #fff;
  box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
  height: 100%;
  margin-top: 20px;
}

.side-menu {
  border-right: none;
  height: 100%;

  :deep(.el-menu-item) {
    height: 48px;
    line-height: 48px;
    margin: 4px 8px;
    border-radius: 4px;

    &:hover {
      background: #f0f9eb;
    }

    &.is-active {
      background: #e1f3d8;
      font-weight: 500;
    }
  }
}

.main-content {
  padding: 0;
  margin-left: 5px;
  background: #f5f7fa;
  min-height: calc(100vh - 60px);
}

.recommend-section {
  margin-top: 32px;

  .section-title {
    color: #333;
    font-size: 18px;
    margin: 0 0 16px;
    padding-bottom: 12px;
    border-bottom: 2px solid #eee;
  }

  .product-card {
    margin-bottom: 20px;
    transition: transform 0.3s;

    &:hover {
      transform: translateY(-3px);
    }

    .product-image {
      height: 180px;
      overflow: hidden;

      img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s;
      }

      &:hover img {
        transform: scale(1.05);
      }
    }

    .product-info {
      padding: 12px;

      .product-title {
        color: #333;
        font-size: 14px;
        margin: 0 0 8px;
      }

      .product-price {
        color: #1691f6;
        font-size: 16px;
        font-weight: 600;
        margin: 0;
      }
    }
  }
}
</style>
