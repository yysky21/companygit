// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RoutePushApplyReqDto.java

package com.sf.openapi.express.sample.route.dto;

import com.sf.openapi.common.entity.BaseEntity;

public class RoutePushApplyReqDto extends BaseEntity
{

    public RoutePushApplyReqDto()
    {
    }

    public String getMailNo()
    {
        return mailNo;
    }

    public void setMailNo(String mailNo)
    {
        this.mailNo = mailNo;
    }

    public String getOrderId()
    {
        return orderId;
    }

    public void setOrderId(String orderId)
    {
        this.orderId = orderId;
    }

    public Integer getStatus()
    {
        return status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    private String mailNo;
    private String orderId;
    private Integer status;
}
