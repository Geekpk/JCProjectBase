//
//  JCDefine.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/18.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit
let Screen_W = UIScreen.main.w()
let Screen_H = UIScreen.main.h()

let IsIphoneX = Screen_W == 375.0 && Screen_H == 812.0
let IsIphoneXR = Screen_W == 414.0 && Screen_H == 896.0

/// 电池栏高度
let StatusBarHeight = UIApplication.shared.statusBarFrame.height

/// 导航栏高度
let NaviHeight: CGFloat = {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    return UIApplication.shared.statusBarFrame.height + 44
}()

/// 底部抽屉栏高度
let TabbarHeight: CGFloat = {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    if statusBarHeight == 20.0 {
        return 49.0
    }else {
        return 49.0 + 34.0
    }
}()

/// 方便UI设计，适配工作
let kUIScreenScale_W : CGFloat = Screen_W / 375.0
