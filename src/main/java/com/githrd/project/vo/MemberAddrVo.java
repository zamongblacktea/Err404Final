package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("MemberAddrVo")
public class MemberAddrVo {

    int mcuraddr_idx;
    String mem_addr1;
    String mem_addr2;
    double mem_latitude;
    double mem_longitude; 
    String addr_name;
    int mem_idx;
    
}
