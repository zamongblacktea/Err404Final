package com.githrd.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.githrd.project.dao.MemberMapper;
import com.githrd.project.dao.OwnerMapper;
import com.githrd.project.dao.RiderMapper;

@Service
public class FindInfoServiceImpl implements FindInfoService {

    @Autowired
    MemberMapper memberMapper;

    @Autowired
    OwnerMapper ownerMapper;

    @Autowired
    RiderMapper riderMapper;

    public String findIdByEmail(String email) {
    
        String id = ownerMapper.selectOneFindInfo(email);
        if (id != null) return id;
    
        id = riderMapper.selectOneFindInfo(email);
        if (id != null) return id;
    
        return null;
    }
    


}
