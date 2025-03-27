<template>
  <div class="app-container">
    <div class="btn">
      目标地址：
      <el-input
          v-model="localLogisticsAddress"
          style="width: 240px"
          autosize
          type="textarea"
          disabled
          placeholder="Please input"
      />
      &nbsp;
      <el-button type="primary" @click="handleConfirm">确认送达</el-button>
    </div>
    <div class="map">
      <BDMap :end-point-address="localLogisticsAddress"></BDMap>
    </div>
  </div>
</template>

<script setup>
import BDMap from '@/components/BDMap/index.vue';
import {ref, onMounted} from 'vue';
import {useRoute, useRouter} from 'vue-router';
import {confirmOrder} from "@/api/system/logistics.js";

const route = useRoute();
const router = useRouter();
const localLogisticsAddress = ref('');
const orderId = ref('');

onMounted(() => {
  // 初始化时从 query 获取参数
  if (route.query.logisticsAddress) {
    localLogisticsAddress.value = decodeURIComponent(route.query.logisticsAddress);
  }
  if (route.query.id) {
    orderId.value = route.query.id;
  }

  console.log('Received logisticsAddress:', localLogisticsAddress.value);
  console.log('Received id:', orderId.value);
});

/**
 * 确认送达
 */
const handleConfirm = () => {
  // 处理确认送达逻辑
  confirmOrder(orderId.value).then(() => {
    router.push({
      path: "/delivery/take"
    });
  })
};
</script>


<style scoped>
.btn {
  margin-left: 20px;
}

</style>
