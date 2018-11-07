//
//  UIviewController_Extension.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit
import MBProgressHUD
extension UIViewController {
    
    /// 添加子控制器
    ///
    /// - Parameter child: 儿子
    func jc_AddSon(_ child : UIViewController) {
        addChild(child)
        child.didMove(toParent: self)
    }
    
    /// 移除子控制器
    func jc_RemoveFromParent(){
        view.removeFromSuperview()
        willMove(toParent: nil)
        removeFromParent()
    }
    
    fileprivate struct Runtime_Keys {
        static let kHUDHandleKey = UnsafeRawPointer.init(bitPattern: "kHUDHandleKey".hashValue)
    }
    private var HUD: MBProgressHUD? {
        get {
            return objc_getAssociatedObject(self, Runtime_Keys.kHUDHandleKey!) as? MBProgressHUD
        }
        set {
            objc_setAssociatedObject(self, Runtime_Keys.kHUDHandleKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 显示菊花
    ///
    /// - Parameters:
    ///   - v: 渲染的父试图
    ///   - hint: 内容
    @objc func showHudInView(_ v: UIView, _ hint: String? = nil) {
        if let h = HUD {
            h.label.text = hint
            h.show(animated: true)
        }else{
            HUD = MBProgressHUD.init(view: v)
            HUD?.removeFromSuperViewOnHide = true
            HUD?.label.text = hint;
            v.addSubview(HUD!)
            HUD?.show(animated: true)
        }
    }
    
    /// 隐藏
    func hideHud() {
        HUD?.hide(animated: true)
        HUD = nil
    }
    
    /// 显示内容
    ///
    /// - Parameter hint: 内容
    func showHint(_ hint: String? = nil) {
        hideHud()
        hudSet(hint)
        
        HUD?.hide(animated: true, afterDelay: 1.5)
    }
    
    /// 显示内容，并有偏移
    ///
    /// - Parameters:
    ///   - hint: 内容
    ///   - yOffset: 偏移
    @objc func showHudInView(hint: String? = nil, yOffset: CGFloat) {
        hudSet(hint)
        HUD?.offset = CGPoint.init(x: (HUD?.offset.x)!, y: 150)
        HUD?.offset = CGPoint.init(x: (HUD?.offset.x)!, y: (HUD?.offset.y)! + yOffset)
        HUD?.hide(animated: true, afterDelay: 1.5)
    }
    
    /// 隐藏hud
    ///
    /// - Parameter hint: 内容
    fileprivate func hudSet(_ hint : String? = nil) {
        let wview : UIView = ((UIApplication.shared.delegate?.window)!)!
        HUD = MBProgressHUD.showAdded(to: wview, animated: true)
        HUD?.isUserInteractionEnabled = false
        // Configure for text only and offset down
        HUD?.mode = MBProgressHUDMode.text
        HUD?.detailsLabel.text = hint
        HUD?.detailsLabel.font = UIFont.systemFont(ofSize: 16)
        HUD?.detailsLabel.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        HUD?.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        HUD?.bezelView.layer.cornerRadius = 10
        HUD?.removeFromSuperViewOnHide = true
    }
}
