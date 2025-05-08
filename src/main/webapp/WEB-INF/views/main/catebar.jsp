<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>카테고리 네비게이션</title>
    <style>
      .category-nav {
        display: flex;
        /* display: inline-block; */
        align-items: center;
        justify-content: center;
        height: 100%;
        font-size: 14px;
        white-space: nowrap;
        padding: 0 10px;
        box-sizing: border-box;
        margin-bottom: 0;
      }

      .category-nav li {
        list-style: none;
        cursor: pointer;
        color: #333;
        padding: 0 12px;
        height: 100%;
        display: flex;
        align-items: center;
        box-sizing: border-box;
        position: relative;
      }

      .category-nav li + li::before {
        position: absolute;
        left: 0;
        color: #ccc;
      
      }

      .category-nav .active {
        background-color: #333;
        color: white;
        font-weight: bold;
        border-radius: 4px;
        padding: 0 12px;
        height: 100%;
        display: flex;
        align-items: center;
      }
    </style>
    <!-- jquery로드 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
    integrity="sha256-/xUj+3OJ+Y2eAR3f6s5M9V74P04eB3vFQ5cDr5f5QcA="
    crossorigin="anonymous"></script>

    <script>
       
        function shop_cate_list(shop_cate_idx){

           $.ajax({
            url : "shop_cate_list.do",
            data: {"shop_cate_idx": shop_cate_idx},
            success:function(res_data){
                     
                $("#category_display").html(res_data);

            },
            error:function(err){
              alert(err.responseText)
            }

           });
        }



        $(document).ready(function () {
            $(".cate-btn").on("click", function () {
                // 기존 active 제거
                $(".cate-btn").removeClass("active");
        
                // 현재 클릭한 버튼만 active 추가
                $(this).addClass("active");
        
                // cate_idx 값 가져오기 (임시)
                let cate_idx = $(this).find(".cate_idx").val();
                console.log("선택된 cate_idx:", cate_idx);

                shop_cate_list(cate_idx);
            });

            //첫번째 화면
            if('${empty param.search}'=='true'){
              if('${ empty param.shop_cate_idx}'=='true'){
              shop_cate_list(0)  ;
            }else{
              const cate_idx =  '${param.shop_cate_idx}';
              shop_cate_list(cate_idx);
            
              $(".cate-btn").removeClass("active");
                     // 현재 클릭한 버튼만 active 추가
              $("#cate-btn-" + cate_idx).addClass("active");
            
            }
            }

        });
    </script>
  
  </head>

  <body>
    <ul class="category-nav">
      <li class="cate-btn active" onclick="location.href='../main/list.do'">전체보기
       <input type="hidden" class="cate_idx" value=""> 
      </li>
      <c:forEach var="cate" items="${cate_list}">
        <li class="cate-btn" onclick="location.href='../main/list.do?shop_cate_idx=${cate.shop_cate_idx}'" id="cate-btn-${cate.shop_cate_idx}">${cate.shop_cate_name}
           <input type="hidden" class="cate_idx" value="${cate.shop_cate_idx}">
        </li>
      </c:forEach>
    </ul>
  </body>
</html>