package com.githrd.demo.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ProductVo")
public class ProductVo {
    int prod_idx;
    String prod_name;
    int prod_price;
    int prod_saleprice;
    String prod_description;
    String prod_company;
    String prod_image_s;
    String prod_image_l;
    String prod_regdate;
    int     cate_idx;

    //할인율 표시하기
    public int getDcRate(){
        //할인율 (정가 - 할인가)/정가 * 100

        //0으로 나누는 오류 예외처리
        if(prod_price==0){

            return 0;
        }
        
        //값이 실수가 나오므로 캐스팅해서 리턴
        return (int)((double)(prod_price - prod_saleprice) / prod_price * 100.0);
    }



}
