<template>
  <div class="app-container">
    <div class="container-area">
      <div style="width: 100%;height: 650px" id="containerGL">
      </div>
    </div>
  </div>
</template>

<script setup>
import {ref, defineEmits} from 'vue'
import {loadBaiDuMap} from "./bmpgl_lib.js"

const props = defineProps({
  endPointAddress: {
    type: String,
    required: true
  }
});

//1、
const {proxy} = getCurrentInstance();
onMounted(() => {
  initMap()
})

// 南京邮电大学通达校区经纬度
const lng = 119.406925;
const lat = 32.33819;

const showTap = ref(false)
const customInfoWindow = ref(null)

let map = {
  center: {lng: 119.400543, lat: 32.332029},
  zoom: 15,
  show: true,
  dragging: true
}

let cityData = ref([
  {enitInt: lng, enitLat: lat, name: '南京邮电大学通达学院'},
])

function initMap() {
  // 传入密钥获取地图回调。
  loadBaiDuMap().then((BMapGL) => {
    // 创建地图实例
    let map = new BMapGL.Map("containerGL", {enableMapClick: false});
    // 添加比例尺控件
    map.addControl(
        new BMapGL.ScaleControl({
          anchor: BMAP_ANCHOR_BOTTOM_LEFT,
          offset: new BMapGL.Size(20, -10),
        })
    );
    // 设置地图允许的最大最小级别
    map.setMinZoom(5)
    map.setMaxZoom(20)
    // 添加缩放控件
    map.addControl(
        new BMapGL.ZoomControl({
          anchor: BMAP_ANCHOR_BOTTOM_RIGHT,
          offset: new BMapGL.Size(10, 10),
        })
    )
    map.disableDoubleClickZoom() //阻止双击放大
    // 保存地图
    map.value = map
    // 创建点坐标 axios => res 获取的初始化定位坐标
    const point = new BMapGL.Point(lng, lat)
    // 初始化地图，设置中心点坐标和地图级别
    map.centerAndZoom(point, 17)
    //开启鼠标滚轮缩放
    map.enableScrollWheelZoom(true)
    //2、

    cityData.value.forEach(item => {
      // 创建点
      const point = new BMapGL.Point(item.enitInt, item.enitLat)
      // 创建标注
      //3、
      let marker = new BMapGL.Marker(point);
      // 将标注添加到地图中
      map.addOverlay(marker)

      marker.addEventListener('click', (e) => {
        let infoWindow = new BMapGL.InfoWindow(customInfoWindow.value, {
          maxWidth: 350,
          minWidth: 350,
          closeOnClick: true
        })
        marker.openInfoWindow(infoWindow)
        console.log(infoWindow)
        showTap.value = true
        onedata.value = e.latLng.lng
      })
    })

    // 3.设置起点与终点
    const riding = new BMapGL.RidingRoute(map, {
      renderOptions: {
        map: map,
        autoViewport: true
      }
    });
    const start = new BMapGL.Point(lng, lat);

    //创建地址解析器实例
    const myGeo = new BMapGL.Geocoder();
    // 将地址解析结果显示在地图上，并调整地图视野
    myGeo.getPoint(props.endPointAddress, function (point) {
      if (point) {
        const endPointLng = point.lng;
        const endPointLat = point.lat;

        map.centerAndZoom(point, 16);
        map.addOverlay(new BMapGL.Marker(point, {title: props.endPointAddress}))
        // 设置终点
        const end = new BMapGL.Point(endPointLng, endPointLat);
        riding.search(start, end);
      } else {
        alert('终点地址没有解析到结果！');
      }
    })
  }).catch((err) => {
    console.log(err)
  })
}

</script>
