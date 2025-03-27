import request from '@/utils/request'

// 获取购物车数量信息
export function getShopCarSize() {
    return request({
        url: '/car/getShopCarSize',
        method: 'get'
    })
}

// 获取购物车信息
export function getShopCar() {
    return request({
        url: '/car/getShopCar',
        method: 'get'
    })
}

// 新增购物车信息
export function updateShopCar(data) {
    return request({
        url: '/car/updateShopCar',
        method: 'post',
        data: data
    })
}

// 删除购物车商品信息
export function removeShopCar(id) {
    return request({
        url: '/car/remove/' + id,
        method: 'get',
    })
}
