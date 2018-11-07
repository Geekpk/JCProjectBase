//
//  JCRefresh.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/22.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import MJRefresh
class JCRefreshHeader: MJRefreshStateHeader {
    lazy var gifView: UIImageView = {
        var gitView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: w(), height: 40))
        gitView.contentMode = .center
        addSubview(gitView)
        return gitView
    }()
    lazy var stateImages: Dictionary<MJRefreshState, [UIImage]> = {
        var stateImages = Dictionary<MJRefreshState, [UIImage]>.init()
        return stateImages
    }()
    
    lazy var stateDurations: Dictionary<MJRefreshState, TimeInterval> = {
        var stateDurations = Dictionary<MJRefreshState, TimeInterval>.init()
        return stateDurations
    }()
    
    func images(_ imgs : [UIImage]?, _ duration : TimeInterval, _ state : MJRefreshState) {
        if let images = imgs, images.count > 0 {
            stateImages[state] = images
            stateDurations[state] = duration
            if let img = images.first, img.size.height > mj_h {
                mj_h = img.size.height
            }
        }
    }
    func images(_ imgs : [UIImage]?, _ state : MJRefreshState) {
        if let images = imgs, images.count > 0 {
            self.images(images, TimeInterval(images.count) * 0.1, state)
        }
    }
    override var pullingPercent: CGFloat {
        get {
            return super.pullingPercent
        }
        set {
            if let images = stateImages[.idle] {
                if state != .idle || images.count == 0 { return }
                gifView.stopAnimating()
                var index : NSInteger = NSInteger(CGFloat(images.count) * pullingPercent)
                if index >= images.count {  index = images.count - 1 }
                gifView.image = images[index]
            }
        }
    }
    override func prepare() {
        super.prepare()
        lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey
        setTitle("下拉刷新", for: .idle)
        setTitle("释放立即刷新", for: .pulling)
        setTitle("正在刷新", for: .refreshing)
        stateLabel.font = UIFont.systemFont(ofSize: 11)
        stateLabel.textColor = UIColor.init(hex6: 0xcccccc)
        mj_h = 64
    }
    override func placeSubviews() {
        super.placeSubviews()
        stateLabel.frame = CGRect.init(x: 0, y: 40, width: w(), height: 12)
        var imgs : [UIImage] = [UIImage].init()
        for i in 0..<18 {
            if let img = UIImage.init(named: String.init(NSString.init(format: "loading_%03ld", i))) {
                imgs.append(img)
            }
        }
        if imgs.count > 0, let img = imgs.first {
            images([img], .pulling)
            images([img], .idle)
            images(imgs, .refreshing)
            lastUpdatedTimeLabel.isHidden = true
        }
    }
    override var state: MJRefreshState {
        get{
            return super.state
        }
        set {
            if state == newValue {
                return
            }
            super.state = newValue
            if newValue == .pulling || newValue == .refreshing {
                if let imgs = stateImages[newValue], imgs.count > 0 {
                    gifView.stopAnimating()
                    if imgs.count == 1 {
                        gifView.image = imgs.last
                    }
                    else{
                        gifView.animationImages = imgs
                        gifView.animationDuration = stateDurations[newValue]!
                        gifView.startAnimating()
                    }
                }
            }
        }
    }
}

class RefreshFooter: MJRefreshAutoNormalFooter {
    override func prepare() {
        super.prepare()
        setTitle("没有更多了", for: .noMoreData)
        setTitle("", for: .idle)
        stateLabel.textColor = UIColor.init(hex6: 0x999999)
    }
}
