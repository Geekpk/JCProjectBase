//
//  URLPath.swift
//  SLProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
/// 服务器环境类型~~~~~测试、线上、预发布
enum RequestWebsiteType : String {
    ///根路径
    case online = "https://www.mql-wh.com/api/mba"
    case test = "http://web.sd.com/api/mba"
    case custom = ""

//    case test = "t1"
//    case readyPush = "t2"
}

/// 获取验证码
let URLGetCode : String = "r=site/client-send-authcode"

/// MBA列表
let URLMBAList : String = "/major/special"

/// 精选
let URLJingXuan : String  = "https://global.sunlands.com/bbs/openapi.php"



