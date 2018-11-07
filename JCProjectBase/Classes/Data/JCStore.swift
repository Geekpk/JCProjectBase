//
//  JCStore.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/22.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
import Alamofire


struct JCResponseStore {
    struct JCKey {
        /// 是否有更多，key
        var hasMore : String? = "hasMore"
        
        /// 状态码
        var code : String? = "code"
        
        /// 回来的数据详情
        var data : String? = "data"
        
        /// 回来提示信息
        var msg : String? = "msg"
    }
    var responseKey : JCKey = JCKey.init()
    /// 是否有更多
    var hasMore: Bool {
        if let ndrs = reponseDetails as? Parameters {
            if let hsm = responseKey.hasMore, ndrs.keys.contains(hsm) {
                return JCCheckDataTypeUtils.boolValueWithObject(ndrs[responseKey.hasMore!])
            }else{
                return customeHasMore
            }
        }
        return false
    }
    var customeHasMore = false
    
    /// 请求回来的所有数据
    var responseObj : Any?
    
    /// 请求回来的有用数据详情
    var reponseDetails : Any?
    
    /// 状态码
    var customStatusCode : Int?
    var statusCode : HTTPCode?
    
    var mantleObject : Any?
    var mantleObjectList : [Any]?
    
}

struct JCRequestStore {
    enum MantleObjectListUpdateStyle {
        case insert
        case replace
    }
    
    ///请求次数
    var requestCount : NSInteger = 0
    
    /// 服务器根路径
    var urlBasePath: String = JCRequestWebsitePath.online()
    
    /// 子路径
    var urlPaths: [String] = [String].init()
    
    /// 分页，key
    var pageKey = "page"
    
    var pageSizeKey = "pageSize"
    
    /// 请求方法
    var method: HTTPMethod = .get
    
    /// 请求参数
    var parameters: Parameters = Parameters.init()
    
    /// 请求头
    var headers: HTTPHeaders = HTTPHeaders.init()
    
    /// 编解码格式
    var encodeing = URLEncoding.default
    
    /// 是否为上传
    var isUpload = false
    
    
    /// 当前数据处理类型
    var updateStyle: MantleObjectListUpdateStyle {
        return currentPage == 1 ? .replace : .insert
    }
    var currentPage: NSInteger {
        if  parameters.keys.contains(pageKey),
            let pageC = parameters[pageKey],
            let c = (pageC as AnyObject).int32Value {
            return NSInteger(c)
        }
        return 1
    }
    
    /// 获取URL
    var urls: [URL] {
        var _urls = [URL].init()
        for urlPath in urlPaths {
            var urlString : String = urlBasePath
            if urlBasePath.count > 0 {
                urlString = urlString + "?"
            }
            urlString = urlString + urlPath
            do {
                _urls.append(try urlString.asURL())
            } catch let error {
                print(error)
            }
        }
        return _urls
    }
}
