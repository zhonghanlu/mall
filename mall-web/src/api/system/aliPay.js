import request from '@/utils/request'

// 调取支付页面
export function aliPay(orderId) {
    return request({
        url: '/alipay/pay',
        method: 'get',
        params: {
            orderId: orderId
        }
    })
}
