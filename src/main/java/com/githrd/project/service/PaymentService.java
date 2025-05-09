package com.githrd.project.service;

import org.json.JSONObject;

import com.githrd.project.vo.PaymentVo;

public interface PaymentService {

    JSONObject verifyPayment(PaymentVo vo) throws Exception;

}
