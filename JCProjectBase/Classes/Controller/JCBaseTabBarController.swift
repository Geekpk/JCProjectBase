//
//  JCBaseTabBarController.swift
//  JCProgramBase
//  Created by 江城 on 2018/10/23.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
class JCBaseTabBarController: UITabBarController {
    
    /// 设置子控制器属性内容
    ///
    /// - Parameters:
    ///   - child: 子控制器
    ///   - title: title
    ///   - img: 未选中时图片
    ///   - selImg: 选中时图片
    ///   - imgInset: 偏移
    //WARNING: 设置偏移时，需要对成，不然会发生点击变小或变大的情况
    func jc_AddChild(_ child : UIViewController, _ title : String?, _ img : String?, _ selImg : String?, _ imgInset : UIEdgeInsets?) {
        if let timg = img {
            child.tabBarItem.image = UIImage.init(named: timg)?.withRenderingMode(.alwaysOriginal)
        }
        if let tselImg = selImg {
            child.tabBarItem.selectedImage = UIImage.init(named: tselImg)?.withRenderingMode(.alwaysOriginal)
        }
        if let insert = imgInset {
            child.tabBarItem.imageInsets = insert
        }
        child.tabBarItem.title = title
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.init(hex6: 0xEFB63F)], for: .selected)
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.init(hex6: 0x999999)], for: .normal)
        
        let navi = JCBaseNavigationController.init(rootViewController: child)
        addChild(navi)
    }
}
