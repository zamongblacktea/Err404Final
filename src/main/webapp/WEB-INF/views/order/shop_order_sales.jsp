<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>




          <div id="salesTable">
            <table class="table">
                <tr class="success">
                    <th>번호</th>
                    <th>메뉴</th>
                    <th>주문일자</th>
                    <th>결제유형</th>
                    <th>총액</th>
                </tr>

    

                <!-- 주문이 없는경우 -->
                <c:if test="${empty sales}">
                    <tr>
                        <td colspan="7" align="center">
                            <font color="red">정산 내역이 없습니다.</font>
                        </td>
                    </tr>                          
                </c:if>

                <tbody>   
                <c:forEach var="sale" items="${ sales }"> 

                        

                       <tr>
                        <td class="content" style="text-align: center;margin-top: 5px;">
                            ${sale.order_idx}
                        </td>

                        <td>
                            ${sale.menu_list}
                        </td>

                        <td>
                            ${sale.order_regdate}
                        </td>
                        <td>
                          ${sale.pay_type}
                        </td>
                        <td>
                          <fmt:formatNumber value="${sale.amount}" type="currency" />
                      </td>
                    </tr>
                </c:forEach>
            
                <!-- 총액 출력 -->
                <tr>
                    <td></td>
                    <td colspan="3" style="text-align: right;">총액 :</td>
                    <td class="currency" colspan="1" id="total_amount" style="text-align: center;">
                        <fmt:formatNumber value="${amount}" type="currency" />
                    </td>
                </tr>
            </tbody>
          </div>

