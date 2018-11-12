//
//  JCBaseViewController.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/17.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
import IQKeyboardManager

@objc open class JCBaseViewController: UIViewController, JCRequestHandleDelegate, UITableViewDelegate {
    public enum StatusBarStyle {
        case black
        case white
    }
    //MARK: - 属性
    /// 用于表示是否需要刷新
    open var isNeedRessetData : Bool = false
    
    private var navigationBarBgv : UIView?
    
    /// 电池栏样式
    open var statusBarStyle : StatusBarStyle = .black
    
    /// 自定义导航栏背景
    open var navigationBarBackgroundView: UIView? {
        if let _ = navigationController,navigationController is JCBaseNavigationController {
            return (navigationController as! JCBaseNavigationController).customizedBackgroundView
        }
        return nil
    }
    
    //MARK: - 生命周期方法
    override open func viewDidLoad() {
        super.viewDidLoad()
        normalSetting()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    //MARK: - 通用工具方法
    /// 通用设置
    @objc open func normalSetting() {
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        if let childs = navigationController?.children, childs.count > 1 { defaultLeftBarButtonItem() }
        requestForData()
        creatUI()
    }
    
    /// 页面加载时做的事情
    @objc open func creatUI(){}
    
    /// 网络请求
    @objc open func requestForData(){}
    
    /// 数据解析，处理
    @objc open func dealWithReseponse(){}
    
    //MARK: - 导航栏事件相关
    /// 设置item
    @objc open func defaultLeftBarButtonItem() {
        showLeftBarButtonItem()
    }
    
    /// 是否隐藏导航栏
    open var isHiddenNavigationBar: Bool = false {
        willSet {
            if isViewLoaded {
                navigationController?.navigationBar.isHidden = newValue
            }
        }
    }
    
    /// 根据statusBarStyle样式设置导航栏颜色样式
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        switch statusBarStyle {
        case .white:    return .lightContent
        case .black:    return .default
        }
    }
    
    /// 设置左边naviItem
    ///
    /// - Parameter img: 图片
    @objc open func showLeftBarButtonItem(_ img : UIImage? = UIImage.init(named: "back")?.byTintColor(UIColor.darkGray)) {
        let item = UIBarButtonItem.init(image: img?.withRenderingMode(.alwaysOriginal),
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.tapLeftBarButtonItem))
        
        navigationItem.setLeftBarButton(item, animated: false)
    }
    
    
    /// 设置左边naviItem
    ///
    /// - Parameters:
    ///   - title: item文字内容
    ///   - titleColor: item字的颜色
    ///   - font: item 字体
    @objc open func showLeftBarButtonItem(_ title : String?,
                               _ titleColor : UIColor = UIColor.init(hex6: 0x3b424c),
                               _ font : UIFont = UIFont.systemFont(ofSize: 14)) {
        let item = UIBarButtonItem.init(title: title,
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.tapLeftBarButtonItem))
        
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : titleColor, NSAttributedString.Key.font : font],
                                    for: UIControl.State.normal)
        
        navigationItem.setLeftBarButton(item, animated: false)
    }
    
    /// 设置左边naviItem
    ///
    /// - Parameters:
    ///   - img: item图片
    ///   - title: item文字内容
    ///   - titleColor: item字的颜色
    ///   - font: item 字体
    @objc open func showLeftBarButtonItem(_ img : UIImage? = UIImage.init(named: "back")?.byTintColor(UIColor.darkGray),
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
    
    /// 设置右边naviItem
    ///
    /// - Parameters:
    ///   - title: item文字内容
    ///   - titleColor: item字的颜色
    ///   - font: item 字体
    @objc open func showRightBarButtonItem(_ title : String?,
                                _ titleColor : UIColor = UIColor.init(hex6: 0x3b424c),
                                _ font : UIFont = UIFont.systemFont(ofSize: 14)) {
        let item = UIBarButtonItem.init(title: title,
                                        style: .plain,
                                        target: self,
                                        action: #selector(self.tapRightBarButtonItem))
        
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : titleColor, NSAttributedString.Key.font : font],
                                    for: UIControl.State.normal)
        
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    
    
    /// 获取clear的图片
    ///
    /// - Parameter frame: 尺寸
    /// - Returns: UIimage
    @objc open func transparentImageWithFrame(_ frame : CGRect) -> UIImage? {
        var rect = CGRect.zero
        rect.size = frame.size
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 设置点击左边item的点击事件
    @objc open func tapLeftBarButtonItem() {
        navigationController?.popViewController(animated: true)
    }
    /// 设置点击右边item的点击事件
    @objc open func tapRightBarButtonItem() {
        
    }
    
    //MARK: - 网络请求通信代理回调
    /// 数据加载成功时候的处理
    ///
    /// - Parameter handle: done
    @objc func dataControllerDidFinishLoading(_ handle: JCNetworkHandle) {
        JCLog(message: "")
    }
    
    /// 数据加载失败时候的处理
    ///
    /// - Parameters:
    ///   - handle: 请求的执行者
    ///   - error: error
    @objc func dataController(_ handle: JCNetworkHandle, didFailWithError error: Error?) {
        JCLog(message: "")
    }
    
    /// 暂停刷新
    ///
    /// - Parameters:
    ///   - t: tableView
    ///   - handle: 网络请求handle
    @objc func endRefreshFooterHeader(_ t : UITableView, _ handle: JCNetworkHandle) {
        endRefreshFooterHeader(t)
        if let h = handle.hasMore, !h {
            t.mj_footer.endRefreshingWithNoMoreData()
        }else{
            t.mj_footer.isHidden = false
            t.mj_footer.resetNoMoreData()
        }
        
    }
    
    /// 调整footer & header状态
    ///
    /// - Parameter t: <#t description#>
    @objc open func endRefreshFooterHeader(_ t : UITableView) {
        if t.mj_footer.isRefreshing {
            t.mj_footer.endRefreshing()
        }
        if t.mj_header.isRefreshing {
            t.mj_header.endRefreshing()
        }
    }
    /// 当数据加载不符合预期时的UI提示
    ///
    /// - Parameter msg: 提示内容
    @objc open func showMSG(_ msg: String) {
        showHint(msg)
    }
    
    //MARK: -tableViewDelegate 方法
    /// 设置cell点击后的效果
    ///
    /// - Parameters:
    ///   - tableView: 假若有tableView
    ///   - indexPath: 位置信息
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
    
    /// 设置cell点击后的效果
    ///
    /// - Parameters:
    ///   - tableView: 假若有tableView
    ///   - cell: cell
    ///   - indexPath: 位置信息
    private func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
}
