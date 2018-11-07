//
//  RequestParameters.swift
//  SLProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Alamofire
@objc protocol RequestHandleDelegate : NSObjectProtocol {
    /**< 接口将要开始加载 */
    @objc optional func dataControllerWillStartLoading(_ handle : NetworkHandle)
    /**< 接口加载加载成功 */
    @objc optional func dataControllerDidFinishLoading(_ handle : NetworkHandle)
    /**< 接口加载取消 */
    @objc optional func dataControllerDidCancelLoading(_ handle : NetworkHandle)
    /**< 接口加载失败 */
    @objc optional func dataController(_ handle : NetworkHandle, didFailWithError error : Error?)
    
    @objc optional func showMSG(_ msg : String)
}

class RequestParameters: NSObject {
    
    /// 请求参数相关区
    var requestStore : JCRequestStore = JCRequestStore()
    
    /// 请求参数
    var parameters: Parameters { return requestStore.parameters }
    
    /// 请求头
    var headers: HTTPHeaders { return requestStore.headers }
    
    /// 回调代理
    weak var delegate : RequestHandleDelegate?
    
    /**< 自定义接口请求失败是否需要toast显示原因    默认YES */
    var showFailToast : Bool = true
    
    /// 网络请求
    var dataRequest : DataRequest?
    
    var requestManager : SessionManager = Alamofire.SessionManager.default
    
    init(_ del : RequestHandleDelegate) {
        delegate = del
    }
}
