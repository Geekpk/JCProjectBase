//
//  JCURLPath.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved
//

import Foundation
/// 服务器环境类型~~~~~测试、线上、预发布
@objc open class JCRequestWebsite: NSObject {
    @objc public static func online() -> String? {
        return nil
    }
    @objc public static func test() -> String? {
        return nil
    }
    @objc public static func custom() -> String? {
        return nil
    }
    @objc open func online() -> String? {
        return nil
    }
    @objc open func test() -> String? {
        return nil
    }
    @objc open func custom() -> String? {
        return nil
    }
    private var _baseURLPath: String?
    @objc open var baseURLPath: String? {
        get{
            return _baseURLPath
        }
        set{
            _baseURLPath = newValue
        }
    }
    /// 子路径
    private var _urlPaths = [String].init()
    @objc open var urlPaths: [String] {
        get {
            return _urlPaths
        }
        set {
            _urlPaths = newValue
        }
    }
}

//MARK: -子路径
public extension JCRequestWebsite {
    
}


///子路径
///如
/// 获取验证码
//let URLGetCode : String = "r=site/client-send-authcode"

/// MBA列表
//let URLMBAList : String = "/major/special"

/// 精选
//let URLJingXuan : String  = "https://global.sunlands.com/bbs/openapi.php"



