//
//  UIImage_Extension.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit
extension UIImage {
    
    static func image(_ name : String) -> UIImage? {
        return UIImage.init(named: name)
    }
    
    static func drawDottedImage(_ imageView : UIImageView) -> UIImage? {
        UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
        imageView.image?.draw(in: CGRect.init(x: 0, y: 0, width: imageView.w(), height: imageView.h()))
        
        if let line = UIGraphicsGetCurrentContext() {
            //设置线条终点形状
            line.setLineCap(.round)
            // 5是每个虚线的长度 1是高度
            //        float lengths[] = {5,1};
            // 设置颜色
            line.setStrokeColor(UIColor.init(white: 0.408, alpha: 1).cgColor)
            //画虚线
            line.setLineDash(phase: 2, lengths: [5.0,1.0])
            line.move(to: CGPoint.init(x: 0, y: 0))
            line.addLine(to: CGPoint.init(x: Screen_W - 40, y: 0))
            line.strokePath()
        }
        // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
        return UIGraphicsGetImageFromCurrentImageContext();
    }
    
    /// 绘制透明图片
    ///
    /// - Parameter size: 大小
    /// - Returns: image
    static func transparentImageWithSize(size : CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    /// 1个像素的透明图片
    ///
    /// - Returns: image
    static func transparentImage() -> UIImage {
        let scal = UIScreen.main.scale
        return transparentImageWithSize(size: CGSize.init(width: 1.0/scal, height: 1.0/scal))
    }
}
