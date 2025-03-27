import request from '@/utils/request'

// 查询商品标签列表
export function listLabel(query) {
    return request({
        url: '/system/label/list',
        method: 'get',
        params: query
    })
}

// 查询商品标签列表
export function listAllLabel(query) {
    return request({
        url: '/system/label/list/all',
        method: 'get',
        params: query
    })
}

// 查询商品标签详细
export function getLabel(id) {
    return request({
        url: '/system/label/' + id,
        method: 'get'
    })
}

// 新增商品标签
export function addLabel(data) {
    return request({
        url: '/system/label',
        method: 'post',
        data: data
    })
}

// 修改商品标签
export function updateLabel(data) {
    return request({
        url: '/system/label',
        method: 'put',
        data: data
    })
}

// 删除商品标签
export function delLabel(id) {
    return request({
        url: '/system/label/' + id,
        method: 'delete'
    })
}
