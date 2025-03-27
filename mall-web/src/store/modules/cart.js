import {defineStore} from 'pinia'
import {getShopCarSize} from "@/api/system/car.js";

export const useCartStore = defineStore('cart', {
    state: () => ({
        size: 0
    }),
    actions: {
        async updateSize() {
            const res = await getShopCarSize()
            this.size = res.data
        }
    }
})