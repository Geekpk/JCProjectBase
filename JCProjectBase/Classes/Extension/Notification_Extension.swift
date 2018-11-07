//
//  Notification_Extension.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/23.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
extension Notification.Name {
    
    /// 监听登陆成功
    public static let loginSuccess : Notification.Name = Notification.Name("LoginSuccess")
    
    /// 监听登录失败
    public static let loginFail : Notification.Name = Notification.Name("LoginFail")
    
    /// 监听定位失败
    public static let updateLocationFail : Notification.Name = Notification.Name("UpdatingLocationFail")
    
    /// 监听定位成功
    public static let updateLocationSuccess : Notification.Name = Notification.Name("UpdateLocationSuccess")
}
