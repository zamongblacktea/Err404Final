package util;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class PaymentUtil {

    private static final String IMP_KEY = "6343605177606552"; // 포트원 REST API 키
    private static final String IMP_SECRET = "252MbgAI2dPpGMtlaTJABHBHytbloi6qatJymz3wwrK8CXHc4KNLtOeC3lFRwDpty5yEdt5j0uJteGCa"; 
    // 포트원 REST API Secret KEY

    //포트원 API 액세스 토큰 발급
    public static String getAccessToken() throws Exception {
        URL url = new URL("https://api.iamport.kr/users/getToken");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        JSONObject requestJson = new JSONObject();
        requestJson.put("imp_key", IMP_KEY);
        requestJson.put("imp_secret", IMP_SECRET);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(requestJson.toString().getBytes());
        }

        if (conn.getResponseCode() == 200) {//API 통신 성공 (엑세스 토큰이 맞을 때)
            return new JSONObject(readResponse(conn)).getJSONObject("response").getString("access_token");
        } else {
            throw new Exception("토큰 발급 실패");
        }
    }

    // 포트원 API에서 결제 내역 조회
    public static JSONObject getPaymentData(String impUid, String accessToken) throws Exception {
        URL url = new URL("https://api.iamport.kr/payments/" + impUid);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", accessToken);

        if (conn.getResponseCode() == 200) {
            return new JSONObject(readResponse(conn));
        } else {
            throw new Exception("결제 내역 조회 실패");
        }
    }

    //HTTP 응답 읽기
    private static String readResponse(HttpURLConnection conn) throws IOException {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = new BufferedReader(new java.io.InputStreamReader(conn.getInputStream()));
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        return sb.toString();
    }

    //결제 검증 실행
    public static String verifyPayment(String impUid, String merchantUid, int orderAmount) {
        try {
            // 1. 액세스 토큰 발급
            String accessToken = getAccessToken();

            // 2. 결제 정보 조회
            JSONObject payment = getPaymentData(impUid, accessToken);

            // 3. 결제 상태 및 금액 검증
            int paidAmount = payment.getJSONObject("response").getInt("amount");
            String status = payment.getJSONObject("response").getString("status");

            if (orderAmount == paidAmount) {
                switch (status) {
                    case "ready":
                        return "가상 계좌 발급 완료";
                    case "paid":
                        return "결제 완료 및 검증 성공";
                    default:
                        return "결제 상태: " + status;
                }
            } else {
                return "결제 금액 불일치. 위변조 가능성 있음";
            }
        } catch (Exception e) {
            return "결제 검증 실패: " + e.getMessage();
        }
    }
}
