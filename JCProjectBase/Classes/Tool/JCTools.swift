//
//  JCTools.swift
//  JCProjectBase
//
//  Created by 江城 on 2018/11/7.
//

import Foundation
extension NSObject {
    
    @objc static func currentViewController() -> UIViewController? {
        var vc : UIViewController?
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != .normal {
            for win in UIApplication.shared.windows {
                if win.windowLevel == .normal {
                    window = win
                    break
                }
            }
        }
        if let v = window?.subviews.first {
            if let rs = v.next as? UIViewController {
                vc = rs
            }else{
                vc = window?.rootViewController
            }
        }
        return vc
    }
    @objc func currentViewController() -> UIViewController? {
        return NSObject.currentViewController()
    }
}
