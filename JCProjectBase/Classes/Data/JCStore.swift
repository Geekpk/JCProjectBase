//
//  JCStore.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/22.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
import Alamofire


public struct JCResponseStore {
    public struct JCKey {
        /// 是否有更多，key
        var hasMore : String? = "hasMore"
        
        /// 状态码
        var code : String? = "code"
        
        /// 回来的数据详情
        var data : String? = "data"
        
        /// 回来提示信息
        var msg : String? = "msg"
    }
    public var responseKey : JCKey = JCKey.init()
    /// 是否有更多
    public var hasMore: Bool {
        if let ndrs = reponseDetails as? Parameters {
            if let hsm = responseKey.hasMore, ndrs.keys.contains(hsm) {
                return JCCheckDataTypeUtils.boolValueWithObject(ndrs[responseKey.hasMore!])
            }else{
                return customeHasMore
            }
        }
        return false
    }
    public var customeHasMore = false
    
    /// 请求回来的所有数据
    public var responseObj : Any?
    
    /// 请求回来的有用数据详情
    public var reponseDetails : Any?
    
    /// 状态码
    public var customStatusCode : Int?
    public var statusCode : HTTPCode?
    
    public var mantleObject : Any?
    public var mantleObjectList : [Any]?
}

public struct JCRequestStore {
    public enum MantleObjectListUpdateStyle {
        case insert
        case replace
    }
    
    ///请求次数
    public var requestCount : NSInteger = 0
    
    /// 服务器根路径
    public var urlPathHandle: JCRequestWebsite = JCRequestWebsite()
    public var baseURLPath: String? {
        get{
            return urlPathHandle.baseURLPath
        }
        set{
            urlPathHandle.baseURLPath = newValue
        }
    }
    public var urlPaths: [String] {
        get {
            return urlPathHandle.urlPaths
        }
        set {
            urlPathHandle.urlPaths = newValue
        }
    }
    
    /// 分页，key
    public var pageKey = "page"
    
    public var pageSizeKey = "pageSize"
    
    /// 请求方法
    public var method: HTTPMethod = .get
    
    /// 请求参数
    public var parameters: Parameters = Parameters.init()
    
    /// 请求头
    public var headers: HTTPHeaders = HTTPHeaders.init()
    
    /// 编解码格式
    public var encodeing = URLEncoding.default
    
    /// 是否为上传
    public var isUpload = false
    
    /// 当前数据处理类型
    public var updateStyle: MantleObjectListUpdateStyle {
        return currentPage == 1 ? .replace : .insert
    }
    public var currentPage: NSInteger {
        if  parameters.keys.contains(pageKey),
            let pageC = parameters[pageKey],
            let c = (pageC as AnyObject).int32Value {
            return NSInteger(c)
        }
        return 1
    }
    
    /// 获取URL
    public var urls: [URL] {
        var _urls = [URL].init()
        for urlPath in urlPathHandle.urlPaths {
            var urlString : String = String()
            if let basePath = urlPathHandle.baseURLPath, basePath.count > 0 {
                urlString = basePath + "?"
            }
            urlString = urlString + urlPath
            if let realUrl = urlString.transformToURLString() {
                _urls.append(realUrl)
            }
        }
        return _urls
    }
}
