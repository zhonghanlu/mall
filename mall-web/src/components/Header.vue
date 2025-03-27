<template>
  <el-header>
    <div class="header-container">
      <div class="logo" @click="mallIndex">
        <img src="@/assets/logo/logo.png" alt="Logo"/>
      </div>
      <div class="search-box">
        <el-input
            v-model="queryParams.productName"
            placeholder="请输入商品信息"
            class="search-input"
        >
          <template #suffix>
            <el-button :icon="Search" @click="handleHeaderSearch" circle/>
          </template>
        </el-input>
      </div>
      <div class="right-section">
        <el-badge :value="carSize" style="margin-right: 20px">
          <el-button :icon="ShoppingCart" @click="handleCart('car')" circle/>
        </el-badge>

        <div class="avatar-container">
          <el-dropdown @command="handleCommand" class="right-menu-item hover-effect" trigger="click">
            <div class="avatar-wrapper">
              <img :src="userStore.avatar" class="user-avatar"
                   style="cursor: pointer;
                          width: 40px;
                          height: 40px;
                          border-radius: 10px;"/>
              <el-icon>
                <caret-bottom/>
              </el-icon>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <span @click="handleUser('profile')">
                  <el-dropdown-item>个人中心</el-dropdown-item>
                </span>
                <el-dropdown-item divided command="logout">
                  <span>退出登录</span>
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
    </div>
  </el-header>
</template>

<script setup>
import {ref, computed} from 'vue';
import {useRouter, useRoute} from 'vue-router';
import {useCartStore} from '@/store/modules/cart.js';
import {CaretBottom, Search, ShoppingCart} from '@element-plus/icons-vue';
import {ElMessageBox} from "element-plus";
import useAppStore from "@/store/modules/app.js";
import useUserStore from "@/store/modules/user.js";
import useSettingsStore from "@/store/modules/settings.js";
import eventBus from "@/utils/eventBus.js"; // 引入 eventBus

const appStore = useAppStore()
const userStore = useUserStore()
const settingsStore = useSettingsStore()
const router = useRouter();
const route = useRoute();
const cartStore = useCartStore();

const queryParams = ref({
  productName: null,
});

const carSize = computed(() => cartStore.size);

const handleHeaderSearch = () => {
  // 如果当前路由不是主页，则跳转到主页
  if (route.path !== '/mall') {
    router.push({path: '/mall', query: {productName: queryParams.value.productName}}).then(() => {
      // 触发 mall 页面的 handleSearch 方法
      eventBus.emit('triggerSearch', queryParams.value.productName);
    });
  } else {
    // 触发 mall 页面的 handleSearch 方法
    eventBus.emit('triggerSearch', queryParams.value.productName);
  }
};

const handleCart = (type) => {
  if (type === 'car') {
    router.push({path: '/mall-user/car', query: {active: 'car'}});
  }
};

const handleUser = (type) => {
  if (type === 'profile') {
    router.push({path: '/mall-user/profile', query: {active: 'profile'}});
  }
};

// 头像下拉
const emits = defineEmits(['setLayout'])

function setLayout() {
  emits('setLayout');
}

function handleCommand(command) {
  switch (command) {
    case "setLayout":
      setLayout();
      break;
    case "logout":
      logout();
      break;
    default:
      break;
  }
}

function logout() {
  ElMessageBox.confirm('确定注销并退出系统吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    userStore.logOut().then(() => {
      location.href = '/index';
    })
  }).catch(() => {
  });
}

/** logo 点击跳转主页 */
const mallIndex = () => {
  router.push({path: '/mall'}).then(() => {
    // 触发 mall 页面的 handleSearch 方法
  });
}

cartStore.updateSize();
</script>

<style scoped lang="scss">
.el-header {
  padding: 10px 20px;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1000;
  display: flex;
  justify-content: space-between;
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
  height: 45px;
  //margin-left: 20px; // 添加左边距
}

.search-box {
  width: 500px; // 增加搜索框宽度
}

.search-input {
  border-radius: 30px; // 修改边框为圆角
  padding: 10px 20px;
  border: 1px solid #dcdcdc;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); // 添加阴影效果
}

.right-section {
  display: flex;
  align-items: center;
  margin-right: 20px; // 添加右边距
}

.right-section .el-button {
  margin-left: 10px;
}

.right-section .el-avatar {
  margin-left: 10px;
  cursor: pointer;
}
</style>