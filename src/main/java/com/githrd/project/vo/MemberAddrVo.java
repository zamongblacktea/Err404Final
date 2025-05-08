package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Alias("MemberAddrVo")
public class MemberAddrVo {

    public MemberAddrVo(int mem_idx, String mem_addr1, String mem_addr2, double mem_longitude, double mem_latitude,
            String addr_name) {
        //TODO Auto-generated constructor stub
    }
    int mcuraddr_idx;
    String mem_addr1;
    String mem_addr2;
    double mem_latitude;
    double mem_longitude; 
    String addr_name;
    int mem_idx;
    
}
