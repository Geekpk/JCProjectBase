//
//  BaseCollectionViewCell.swift
//  MBAComing
//
//  Created by 江城 on 2018/10/24.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    func config(_ m : Model) { }
    static var cellClassName : String {
        return NSString.init(cString: object_getClassName(self), encoding: String.Encoding.utf8.rawValue)!.components(separatedBy: ".").last!
    }
    /// 注册
    ///
    /// - Parameters:
    ///   - table: table
    ///   - isNIB: 是否注册nib
    ///   - identify: id & 以及nib名字
    // WARNING: --- nib名字与关联class名字必须相同
    
    static func register(_ collect: UICollectionView, _ isNIB : Bool = true, _ identify : String? = nil) {
        if isNIB {
            let nib = UINib.init(nibName: cellClassName, bundle: nil)
            collect.register(nib, forCellWithReuseIdentifier: identify ?? cellClassName)
        }else{
            collect.register(object_getClass(self), forCellWithReuseIdentifier: identify ?? cellClassName)
        }
    }
}
