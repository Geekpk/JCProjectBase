//
//  BaseController.swift
//  SLProgramBase
//
//  Created by 江城 on 2018/10/17.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
import IQKeyboardManager

class BaseViewController: UIViewController, RequestHandleDelegate, UITableViewDelegate {
    var isHiddenNavigationBar : Bool = false
    var isNeedRefresh : Bool = false
    
    private var navigationBarBgv : UIView?
    
    var city : String = "北京"
    
    var navigationBarBackgroundView: UIView? {
        if let _ = navigationController,navigationController is BaseNavigationController {
            return (navigationController as! BaseNavigationController).customizedBackgroundView
        }
        return nil
    }
    
    @objc func updateLocation(_ notify : Notification) {
        if let info = notify.userInfo, let _city = info["City"] as? String {
            city = _city
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalSetting()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.updateLocationSuccess, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocation(_:)), name: Notification.Name.updateLocationSuccess, object: nil)
        LocationLoad.share.startLoading()
        
        var scrollView : UIScrollView?
        for v in view.subviews {
            if v is UITableView || v is UICollectionView {
                scrollView = v as? UIScrollView
                break
            }
        }
        if #available(iOS 11.0, *) {
            scrollView?.contentInsetAdjustmentBehavior = automaticallyAdjustsScrollViewInsets ? .never : .automatic
        } else {
            //预留
        }
        
        /// 对navibar的处理
        if let navi = navigationController {
            navi.setNavigationBarHidden(isHiddenNavigationBar, animated: animated)
            /// 对tabbar的处理
            tabBarController?.tabBar.isHidden = navi.children.count > 1
        }
    }
    
    func normalSetting() {
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        if let childs = navigationController?.children, childs.count > 1 { defaultLeftBarButtonItem() }
        requestForData()
        creatUI()
    }
    
    /// 页面加载时做的事情
    func creatUI(){}
    
    /// 网络请求
    func requestForData(){}
    
    /// 数据解析，处理
    func dealWithReseponse(){}
    
    func dataControllerDidFinishLoading(_ handle: NetworkHandle) {
        JCLog(message: "")
    }
    func dataController(_ handle: NetworkHandle, didFailWithError error: Error?) {
        JCLog(message: "")
    }
    
    func showMSG(_ msg: String) {
        showHint(msg)
    }
    
    /// 设置item
    func defaultLeftBarButtonItem() {
        showLeftBarButtonItem()
    }
    
    
    
    func showLeftBarButtonItem(_ img : UIImage? = UIImage.init(named: "back")?.byTintColor(UIColor.darkGray)) {
        let item = UIBarButtonItem.init(image: img?.withRenderingMode(.alwaysOriginal),
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.tapLeftBarButtonItem))
        
        navigationItem.setLeftBarButton(item, animated: false)
    }
    
    func showLeftBarButtonItem(_ title : String?,
                               _ color : UIColor = UIColor.init(hex6: 0x3b424c),
                               _ font : UIFont = UIFont.systemFont(ofSize: 14)) {
        let item = UIBarButtonItem.init(title: title,
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.tapLeftBarButtonItem))
        
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : font],
                                    for: UIControl.State.normal)
        
        navigationItem.setLeftBarButton(item, animated: false)
    }
    func showLeftBarButtonItem(_ img : UIImage? = UIImage.init(named: "back")?.byTintColor(UIColor.darkGray),
                               _ title : String?,
                               _ color : UIColor = UIColor.init(hex6: 0x3b424c),
                               _ font : UIFont = UIFont.systemFont(ofSize: 14)) {
        let item = UIBarButtonItem.init(title: title,
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.tapLeftBarButtonItem))
        
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : font],
                                    for: UIControl.State.normal)
        item.setBackgroundImage(img, for: .normal, barMetrics: .default)
        navigationItem.setLeftBarButton(item, animated: false)
    }
    
    func showRightBarButtonItem(_ title : String?,
                               _ color : UIColor = UIColor.init(hex6: 0x3b424c),
                               _ font : UIFont = UIFont.systemFont(ofSize: 14)) {
        let item = UIBarButtonItem.init(title: title,
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.tapRightBarButtonItem))
        
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : font],
                                    for: UIControl.State.normal)
        
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    
    
    /// 获取clear的图片
    ///
    /// - Parameter frame: 尺寸
    /// - Returns: UIimage
    func transparentImageWithFrame(_ frame : CGRect) -> UIImage? {
        var rect = CGRect.zero
        rect.size = frame.size
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    @objc func tapLeftBarButtonItem() {
        navigationController?.popViewController(animated: true)
    }
    @objc func tapRightBarButtonItem() {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
}
