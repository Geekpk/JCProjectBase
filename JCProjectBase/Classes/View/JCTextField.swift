//
//  JCTextField.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/25.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit

open class JCTextField: UITextField {
    
    /// 设置偏移
    ///
    /// - Parameter bounds: <#bounds description#>
    /// - Returns: <#return value description#>
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(origin: CGPoint.init(x: 10, y: 0), size: bounds.size)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(origin: CGPoint.init(x: 10, y: 0), size: bounds.size)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
