package com.ruoyi.common.core.domain.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 用户注册对象
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class RegisterBody extends LoginBody {
    /**
     * 注册角色ID
     */
    private Long roleId;
}
