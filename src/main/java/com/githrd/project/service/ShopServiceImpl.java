package com.githrd.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.vo.ShopInfoVo;

@Service
public class ShopServiceImpl implements ShopService{
    @Autowired
    ShopInfoMapper shopInfoMapper;

    @Override
    public List<ShopInfoVo> selectListAll() {
        return shopInfoMapper.selectListAll();  
    }


}
