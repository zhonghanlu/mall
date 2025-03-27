package com.ruoyi.web.controller.system;

import com.alibaba.fastjson2.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.ruoyi.common.config.AliPayConfig;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.ShopOrder;
import com.ruoyi.system.service.IShopOrderService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/alipay")
public class AliPayController {

    // 支付宝沙箱网关地址
    private static final String GATEWAY_URL = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";
    private static final String FORMAT = "JSON";
    private static final String CHARSET = "UTF-8";
    //签名方式
    private static final String SIGN_TYPE = "RSA2";
    @Resource
    private AliPayConfig aliPayConfig;
    @Resource
    private IShopOrderService shopOrderService;

    @GetMapping("/pay")
    public void pay(@RequestParam Long orderId, HttpServletResponse httpResponse) throws Exception {
        // 查询订单信息
        ShopOrder shopOrder = shopOrderService.selectShopOrderById(orderId);
        if (Objects.isNull(shopOrder)) {
            return;
        }
        // 1. 创建Client，通用SDK提供的Client，负责调用支付宝的API
        AlipayClient alipayClient = new DefaultAlipayClient(GATEWAY_URL,
                aliPayConfig.getAppId(),
                aliPayConfig.getAppPrivateKey(),
                FORMAT,
                CHARSET,
                aliPayConfig.getAlipayPublicKey(),
                SIGN_TYPE);
        // 2. 创建 Request并设置Request参数
        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        // 发送请求的 Request类
        request.setNotifyUrl(aliPayConfig.getNotifyUrl());
        JSONObject bizContent = new JSONObject();
        // 我们自己生成的订单编号
        bizContent.put("out_trade_no", shopOrder.getId());
        // 订单的总金额 - 固定加 10 元配送费
        BigDecimal bigDecimal = new BigDecimal(shopOrder.getProductTotalPrice());
        BigDecimal resultTotalPrice = bigDecimal.add(new BigDecimal("10"));
        bizContent.put("total_amount", resultTotalPrice.doubleValue());
        // 支付的名称
        bizContent.put("subject", "团购商城支付");

        // 固定配置
        bizContent.put("product_code", "FAST_INSTANT_TRADE_PAY");
        request.setBizContent(bizContent.toString());
        request.setReturnUrl("http://localhost:8888/mall");
        // 支付完成后自动跳转到本地页面的路径
        // 执行请求，拿到响应的结果，返回给浏览器
        String form = "";
        try {
            form = alipayClient.pageExecute(request).getBody();
            // 调用SDK生成表单
        } catch (AlipayApiException e) {
            throw new ServletException("支付页面请求获取失败");
        }
        httpResponse.setContentType("text/html;charset=" + CHARSET);
        httpResponse.getWriter().write(form);
        // 直接将完整的表单html输出到页面
        httpResponse.getWriter().flush();
        httpResponse.getWriter().close();
    }

    @PostMapping("/notify")
    // 注意这里必须是POST接口
    public void payNotify(HttpServletRequest request) throws Exception {
        if (request.getParameter("trade_status").equals("TRADE_SUCCESS")) {
            System.out.println("=========支付宝异步回调========");
            Map<String, String> params = new HashMap<>();
            Map<String, String[]> requestParams = request.getParameterMap();
            for (String name : requestParams.keySet()) {
                params.put(name, request.getParameter(name));
            }
            String sign = params.get("sign");
            String content = AlipaySignature.getSignCheckContentV1(params);
            boolean checkSignature = AlipaySignature.rsa256CheckContent(content, sign, aliPayConfig.getAlipayPublicKey(), "UTF-8");
            // 验证签名
            // 支付宝验签
            if (checkSignature) {
                // 验签通过
                System.out.println("交易名称: " + params.get("subject"));
                System.out.println("交易状态: " + params.get("trade_status"));
                System.out.println("支付宝交易凭证号: " + params.get("trade_no"));
                System.out.println("商户订单号: " + params.get("out_trade_no"));
                System.out.println("交易金额: " + params.get("total_amount"));
                System.out.println("买家在支付宝唯一id: " + params.get("buyer_id"));
                System.out.println("买家付款时间: " + params.get("gmt_payment"));
                System.out.println("买家付款金额: " + params.get("buyer_pay_amount"));
                String tradeNo = params.get("out_trade_no");
                String gmtPayment = params.get("gmt_payment");
                String alipayTradeNo = params.get("trade_no");
                String payAmount = params.get("buyer_pay_amount");
                // 更新订单状态为已支付，设置支付信息
                ShopOrder shopOrder = shopOrderService.selectShopOrderById(Long.parseLong(tradeNo));

                shopOrder.setOrderStatus(1L); // 待发货
                shopOrder.setOrderTotalPrice(payAmount);
                shopOrder.setPayTime(DateUtils.parseDate(gmtPayment));
                shopOrder.setPayNo(alipayTradeNo);
                shopOrderService.updateShopOrder(shopOrder);
            }
        }
    }
}