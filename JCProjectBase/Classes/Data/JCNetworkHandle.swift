//
//  JCNetworkHandle.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/17.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import Mantle

@objc open class JCNetworkHandle: JCRequestParameters {
    
    open var responseStore : JCResponseStore = JCResponseStore.init()
    
    /// 自定义解析字段
    ///
    /// - Parameters:
    ///   - msg: 提示信息
    ///   - data: 详细内容
    ///   - code: 状态码
    ///   - hasMore: hasmore字段
    @objc open func customeResponseKey(msg : String = "msg", data : String = "data", code : String = "code", hasMore : String?) {
        responseStore.responseKey.msg = msg
        responseStore.responseKey.data = data
        responseStore.responseKey.code = code
        responseStore.responseKey.hasMore = hasMore
    }
    
    public var isPrintResponseLog = true
    
    /// 是否有更多
    open var hasMore: Bool? { return responseStore.hasMore }
    
    open var customeHasMore: Bool {
        get {
            return hasMore ?? false
        }
        set {
            responseStore.customeHasMore = newValue
        }
    }
    /// 请求回来的有用数据详情
    open var reponseDetails: Any? { return responseStore.reponseDetails }
    /// 请求回来的所有数据
    open var responseObj: Any? { return responseStore.responseObj }
    /// 状态码
    open var statusCode: HTTPCode? { return  responseStore.statusCode }
    
    /// keys
    open var responseKey: JCResponseStore.JCKey { return  responseStore.responseKey }
    
    /// 保存返回是单个model时的数据
    open var mantleObject: Any? { return responseStore.mantleObject }
    
    open var mantleObjectList : [Any]? {
        return responseStore.mantleObjectList
    }
    
    /// 回来的是单个model
    open var mantleKeyPath : String? { return responseKey.data }
    
    /// 回来的是list
    open var mantleListKeyPath : String? { return responseKey.data }
    
    
    /// 成功回调
    private var _success : ((Any?)->())?
    
    /// 失败回调
    private var _fail : ((Error?)->())?
    
    /// 更新参数
    ///
    /// - Parameter para: para
    @objc func updateParameters(_ para: Parameters?) {
        if let p = para {
            for (k, v) in p {
                requestStore.parameters[k] = v
            }
        }
    }
    
    /// 网络请求 获取数据
    ///
    /// - Parameters:
    ///   - success: 成功的回调
    ///   - fail: 失败的回调
    @objc open func request(CompleteHandle success: ((Any?)->())? = nil, CompleteHandle fail: ((Error?)->())? = nil ) {
        if let s = success { _success = s }
        if let f = fail { _fail = f }
        request(false)
    }
    
    
    /// 请求数据，是否需要重试
    ///
    /// - Parameter isRetry: retry
    private func request(_ isRetry : Bool = false) {
        if requestStore.urls.count < 1 { return }
        if !isRetry { requestStore.requestCount = 0 }
        
        /// 执行即将获取代理
        if let d = delegate, d.responds(to: #selector(JCRequestHandleDelegate.dataControllerWillStartLoading(_:))) {
            d.dataControllerWillStartLoading!(self)
        }
        ///请求数据
        if requestStore.isUpload { uploadDo() }else{ requestDo() }
    }
    
    
    /// 再次请求
    @objc open func requestMore() {
        if requestStore.parameters.keys.contains(requestStore.pageKey) {
            requestStore.parameters[requestStore.pageKey] = requestStore.parameters[requestStore.pageKey] as! Int + 1
//            requestStore.parameters[requestStore.pageKey] = NSNumber.init(value: ((requestStore.parameters[requestStore.pageKey] as Int).int32Value + 1))
        }
        if requestStore.parameters.keys.contains(requestStore.pageSizeKey) {
//            requestStore.parameters[requestStore.pageSizeKey] = NSNumber.init(value: ((requestStore.parameters[requestStore.pageSizeKey] as AnyObject).int32Value + 1))
            requestStore.parameters[requestStore.pageSizeKey] = requestStore.parameters[requestStore.pageSizeKey] as! Int
        }
        request(false)
    }
    
    @objc open func updateRequest() {
        if requestStore.parameters.keys.contains(requestStore.pageKey) {
            requestStore.parameters[requestStore.pageKey] = 1
        }
        request(false)
    }
    
    /// 取消请求
    private func cancelRequest() {
        if let r = dataRequest {
            r.cancel()
            dataRequest = nil
            /// 执行取消代理
            if let d = delegate, d.responds(to: #selector(JCRequestHandleDelegate.dataControllerDidCancelLoading)) {
                d.dataControllerDidCancelLoading!(self)
            }
        }
    }
    
    /// 数据处理
    ///
    /// - Parameter response: 请求回来的数据
    private func dealWithData(_ response : DataResponse<Any>) {
        JCLog(message: "")
        if let rs = response.response, let code = HTTPCode(rawValue: rs.statusCode) {
            responseStore.statusCode = code
        }
        //TODO: --待调整
        if isValidWithObject(response.result.value) {
            ///解析数据
            analysisResponse(response.result.value as AnyObject)
            if let _ = response.error {
                /// 执行失败代理，回来的response显示请求错误
                if let d = self.delegate, d.responds(to: #selector(JCRequestHandleDelegate.dataController(_:didFailWithError:))) {
                    d.dataController!(self, didFailWithError: response.error)
                }
                
                if let f = self._fail { f(response.error) }
                return
            }
            requestStore.requestCount = 0
            /// 执行成功代理
            if let d = self.delegate, d.responds(to: #selector(JCRequestHandleDelegate.dataControllerDidFinishLoading(_:))) {
                d.dataControllerDidFinishLoading!(self)
            }
            if let s = self._success { s(response.result.value) }
        }else{
            /// 执行失败代理，请求失败
            if let d = self.delegate {
                if  d.responds(to: #selector(JCRequestHandleDelegate.dataController(_:didFailWithError:))) {
                    d.dataController!(self, didFailWithError: response.error)
                }
                if showFailToast {
                    ///显示失败信息
                    if d.responds(to: #selector(JCRequestHandleDelegate.showMSG(_:))){
                        //显示错误提示
                        if let error = response.error {
                            d.showMSG!(error.localizedDescription)
                        }
                    }
                }
            }
            
            if let f = self._fail { f(response.error) }
            
        }
    }
    
    /// 解析数据城model
    ///
    /// - Parameter response: 请求回来的数据
    private func analysisResponse(_ response : AnyObject) {
        JCLog(message: "")
        if  let keyPath = mantleKeyPath,
            let mantleClass = mantleModelClass(),
            let mantleJson = response.value(forKeyPath: keyPath){
            if mantleJson is [AnyHashable : Any] {
                do {
                    /// 转换模型
                    responseStore.mantleObject = try MTLJSONAdapter.model(of: mantleClass, fromJSONDictionary: mantleJson as? [AnyHashable : Any])
                }catch let error {
                    ///error log
                    JCLog(message: error.localizedDescription)
                }
            }else if mantleJson is String {
                let mantleJsonString : String = mantleJson as! String
                if let data = mantleJsonString.data(using: String.Encoding.utf8) {
                    do {
                        if let mantleJsonToDic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [AnyHashable : Any] {
                            do {
                                /// 转换模型
                                responseStore.mantleObject = try MTLJSONAdapter.model(of: mantleClass, fromJSONDictionary: mantleJsonToDic)
                            }catch let error {
                                ///error log
                                JCLog(message: error.localizedDescription)
                            }
                        }
                    }catch let error{
                        ///error log
                        JCLog(message: error.localizedDescription)
                    }
                }
            }
        }
        if let keyPath = mantleListKeyPath,
            let mantleJson = response.value(forKeyPath: keyPath) as? [Any],
            let mantleListClass = mantleListModelClass() {
            do {
                /// 转换模型
                let mantlelist = try MTLJSONAdapter.models(of: mantleListClass, fromJSONArray: mantleJson)
                ///不同处理情况
                switch requestStore.updateStyle {
                case .insert:
                    if let _ = responseStore.mantleObjectList {
                        responseStore.mantleObjectList?.append(contentsOf: mantlelist)
                    }else{
                        responseStore.mantleObjectList = [Any].init(mantlelist)
                    }
                case .replace:
                    responseStore.mantleObjectList = [Any].init(mantlelist)
                }
            }catch let error{
                JCLog(message: error.localizedDescription)
            }
        }
    }
    
    @objc open func mantleModelClass() -> AnyClass? {
        return JCModel.classForCoder()
    }
    @objc open func mantleListModelClass() -> AnyClass? {
        return mantleModelClass()
    }
    /// 处理上传回来的数据
    ///
    /// - Parameter result: result
    private func dealWithUploadReponse(_ result: SessionManager.MultipartFormDataEncodingResult) {
        switch result {
        case .success(let upload , _ , _):
            weak var weakSelf = self
            upload.responseJSON(completionHandler: { (response) in
                let strongSelf = weakSelf
                strongSelf?.dealWithData(response)
            })
        case .failure(let error):
            JCLog(message: "fail upload:" + error.localizedDescription)
        }
    }
    
    
    ///上传时做的处理
    @objc open func uploadDo() {
        JCLog(message: "")
        weak var weakSelf = self
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            /// 拼接上传的数据
            let stongSelf = weakSelf
            if let p = stongSelf?.requestStore.parameters {
                for (key, value) in p {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
            //继续拼，举例
//            if let data = imageData{
//                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
//            }
        }, to: requestStore.urls[requestStore.requestCount], encodingCompletion: { (result) in
            
            /// 处理回来的response
            let stongSelf = weakSelf
            stongSelf?.dealWithUploadReponse(result)
        })
    }
    
    
    /// 普通网络请求做的处理
    private func requestDo() {
        JCLog(message: "\nurls: \(requestStore.urls[requestStore.requestCount]) \n" +
            "method: \(requestStore.method.rawValue) \n" +
            "parameters: \(requestStore.parameters.description) \n")
        weak var weakSelf = self
        dataRequest = Alamofire.request(requestStore.urls[requestStore.requestCount],
                                        method: requestStore.method,
                                        parameters: requestStore.parameters,
                                        encoding: requestStore.encodeing,
                                        headers: requestStore.headers)
        dataRequest!.responseJSON { (response) in
            DispatchQueue.main.async(execute: {
                let stongSelf = weakSelf
                stongSelf?.jcLog(response)
                /// 处理回来的数据
                stongSelf?.dealWithData(response)
            })
        }
    }
    private func jcLog(_ rs : DataResponse<Any>) {
        
        var log : String
        if let trs = rs.result.value {
            log = isPrintResponseLog ? "\(trs)" : "Success"
        }else{
            if let error = rs.error {
                if let res = rs.response {
                    log = "\(res.statusCode) :" + error.localizedDescription
                }else{
                    log = error.localizedDescription
                }
            }
            else{ log = "NULL" }
        }
        let str = "\n" +
            "reponse: \(log)"
        JCLog(message: str)
    }
    
    /// 判断数据是否有效
    ///
    /// - Parameter obj: 回来的数据
    /// - Returns: bool
    private func isValidWithObject(_ obj : Any?) -> Bool {
        JCLog(message: "")
        if let jj : NSDictionary = obj as? NSDictionary {
            responseStore.responseObj = jj
            responseStore.reponseDetails = jj[responseKey.data!]
            responseStore.customStatusCode = jj[responseKey.code!] as? Int
            if let code = responseStore.statusCode, code.rawValue >= HTTPCode.Success.rawValue && code.rawValue <= HTTPCode.Success_Partial_Content.rawValue { return true }
            if showFailToast {
                ///显示失败信息
                if let d = delegate,
                    d.responds(to: #selector(JCRequestHandleDelegate.showMSG(_:)))
                     {
                        //显示错误提示
                    if let failTip = jj[responseKey.msg!] as? String {
                        d.showMSG!(failTip)
                    }else if let tip = responseStore.statusCode?.jc_description() {
                        d.showMSG!(tip)
                    }
                }
            }
        }
        return false
    }
}

public struct JCParameterEncoding: ParameterEncoding {
    private var parameters : [String]
    init(_ parameters : [String]) {
        self.parameters = parameters
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlReq = urlRequest.urlRequest
        let data = try JSONSerialization.data(withJSONObject: self.parameters, options: [])
        if urlReq?.value(forHTTPHeaderField: "Content-Type") == nil {
            urlReq?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        urlReq?.httpBody = data
        return urlReq!
    }
}
