//
//  JCHTTPStatusCode.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/17.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation

/// 网络请求的状态码解析
@objc public enum HTTPCode : Int {
    case Success = 200
    case Success_Created
    case Success_Accepted
    case Success_Non_authoritative_Information
    case Success_No_Content
    case Success_Reset_Content
    case Success_Partial_Content = 206
    
    case Multiple_Choices = 300
    case Moved_Permanently
    case Found
    case See_Other
    case Not_Modified
    case Use_Proxy
    case Unused
    case Temporary_Redirect = 307
    
    case Bad_Request = 400
    case Unauthorized
    case Payment_Required
    case Forbidden
    case Not_Found = 404
    case Method_Not_Allowed
    case Not_Acceptable
    case Proxy_Authentication_Required
    case Request_Timeout
    case Conflict
    case Gone = 410
    case Length_Required
    case Precondition_Failed
    case Request_Entity_Too_Large
    case Request_url_Too_Long
    case Unsupported_Media_Type
    case UnKnow
    case Expectation_Failed = 417
    
    case Internal_Server_Error = 500
    case Not_Implemented
    case Bad_Gateway
    case Service_Unavailable
    case Gateway_Timeout
    case HTTP_Version_Not_Supported = 505
    
    case Unknow_Other
    
    public func jc_description() -> String? {
        switch self {
case .Success:                                  return "请求成功"
case .Success_Created:                          return "请求被创建完成，同时新的资源被创建。"
case .Success_Accepted:                         return "供处理的请求已被接受，但是处理未完成。"
case .Success_Non_authoritative_Information:    return "文档已经正常地返回，但一些应答头可能不正确，因为使用的是文档的拷贝。"
case .Success_No_Content:                       return "没有新文档。浏览器应该继续显示原来的文档。如果用户定期地刷新页面，而Servlet可以确定用户文档足够新，这个状态代码是很有用的。"
case .Success_Reset_Content:                    return "没有新文档。但浏览器应该重置它所显示的内容。用来强制浏览器清除表单输入内容。"
case .Success_Partial_Content:                  return "客户发送了一个带有Range头的GET请求，服务器完成了它。"
    
case .Multiple_Choices:                 return "多重选择。链接列表。用户可以选择某链接到达目的地。最多允许五个地址。"
case .Moved_Permanently:                return "所请求的页面已经转移至新的url。"
case .Found:                            return "所请求的页面已经临时转移至新的url。"
case .See_Other:                        return "所请求的页面可在别的url下被找到。"
case .Not_Modified:                     return "未按预期修改文档。客户端有缓冲的文档并发出了一个条件性的请求（一般是提供If-Modified-Since头表示客户只想比指定日期更新的文档）。服务器告诉客户，原来缓冲的文档还可以继续使用。"
case .Use_Proxy:                        return "客户请求的文档应该通过Location头所指明的代理服务器提取。"
case .Unused:                           return "此代码被用于前一版本。目前已不再使用，但是代码依然被保留。"
case .Temporary_Redirect:               return "被请求的页面已经临时移至新的url。"
    
case .Bad_Request:                      return "服务器无法找到被请求的页面。"
case .Unauthorized:                     return "被请求的页面需要用户名和密码。"
case .Payment_Required:                 return "此代码尚无法使用。"
case .Forbidden:                        return "对被请求页面的访问被禁止。"
case .Not_Found:                        return "服务器无法找到被请求的页面。"
case .Method_Not_Allowed:               return "请求中指定的方法不被允许。"
case .Not_Acceptable:                   return "服务器生成的响应无法被客户端所接受。"
case .Proxy_Authentication_Required:    return "用户必须首先使用代理服务器进行验证，这样请求才会被处理。"
case .Request_Timeout:                  return "请求超出了服务器的等待时间。"
case .Conflict:                         return "由于冲突，请求无法被完成。"
case .Gone:                             return "被请求的页面不可用。"
case .Length_Required:                  return "'Content-Length' 未被定义。如果无此内容，服务器不会接受请求。"
case .Precondition_Failed:              return "请求中的前提条件被服务器评估为失败。"
case .Request_Entity_Too_Large:         return "由于所请求的实体的太大，服务器不会接受请求。"
case .Request_url_Too_Long:             return "由于url太长，服务器不会接受请求。当post请求被转换为带有很长的查询信息的get请求时，就会发生这种情况。"
case .Unsupported_Media_Type:           return "由于媒介类型不被支持，服务器不会接受请求。"
case .UnKnow:                           return "UnKnown reason"
case .Expectation_Failed:               return "Expectation Failed"
    
case .Internal_Server_Error:            return "请求未完成。服务器遇到不可预知的情况。"
case .Not_Implemented:                  return "请求未完成。服务器不支持所请求的功能。"
case .Bad_Gateway:                      return "请求未完成。服务器从上游服务器收到一个无效的响应。"
case .Service_Unavailable:              return "请求未完成。服务器临时过载或当机。"
case .Gateway_Timeout:                  return "网关超时。"
case .HTTP_Version_Not_Supported:       return "服务器不支持请求中指明的HTTP协议版本。"
default:    return nil
        }
    }
}
