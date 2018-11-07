//
//  BaseNavigationController.swift
//  SLProgramBase
//
//  Created by 江城 on 2018/10/23.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import YYKit
class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    private var customizedBgv : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = weakSelf
        
        navigationBar.isTranslucent = false
        
        /// navi的设置
        let navi = UINavigationBar.appearance()
        navi.setBackgroundImage(UIImage.init(), for: .any, barMetrics: .default)
        navi.shadowImage = UIImage.init(color: UIColor.init(hex6: 0xdddddd),
                                        size: CGSize.init(width: Screen_W, height: 1/UIScreen.main.scale))
    }
    func enableSideSlip(_ enable : Bool) {
        weak var weakSelf = self
        interactivePopGestureRecognizer?.isEnabled = enable
        interactivePopGestureRecognizer?.delegate = enable ? weakSelf : nil
    }
    
    var customizedBackgroundView: UIView {
        get {
            if let v = customizedBgv { return v }
            var rect = CGRect.init(x: 0, y: -20, width: UIScreen.main.w(), height: 64)
            if IsIphoneX {
                rect = CGRect.init(x: 0, y: -44, width: UIScreen.main.w(), height: 88)
            }
            customizedBgv = UIView.init(frame: rect)
            return customizedBgv!
        }
        set {
            customizedBgv = newValue
        }
    }
    
    
    /// 转屏
    override var shouldAutorotate: Bool {
        get{
            if let top = topViewController { return top.shouldAutorotate }
            return true
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            if let top = topViewController { return top.supportedInterfaceOrientations }
            return .portrait
        }
    }
}
