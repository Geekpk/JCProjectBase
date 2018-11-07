//
//  JCURLPath.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved
//

import Foundation
/// 服务器环境类型~~~~~测试、线上、预发布
class JCRequestWebsitePath: NSObject {
    private static let _online : String = "1"
    private static let _test : String = "1"
    private static let _custom : String = "1"
    
    static func online() -> String {
        return _online
    }
    static func test() -> String {
        return _test
    }
    static func custom() -> String {
        return _custom
    }
}

//MARK: -子路径
extension JCRequestWebsitePath {
    
}


///子路径
///如
/// 获取验证码
//let URLGetCode : String = "r=site/client-send-authcode"

/// MBA列表
//let URLMBAList : String = "/major/special"

/// 精选
//let URLJingXuan : String  = "https://global.sunlands.com/bbs/openapi.php"



