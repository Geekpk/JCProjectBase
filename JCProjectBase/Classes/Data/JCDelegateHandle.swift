//
//  JCDelegateHandle.swift
//  MBAComing
//
//  Created by 江城 on 2018/10/25.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
class JCDelegateHandle: NSObject {
    private var _source : [[Any]]?
    
    private var _cellClass : AnyClass?
    
    var cellClassName: String {
        assert(_cellClass == nil, "cell class not set")
        return String.init(cString: object_getClassName(_cellClass))
    }
    
    var sections: Int {
        if let s = _source { return s.count }
        return 0
    }
    
    var source: [[Any]]? {
        return _source
    }
    
    func rows(_ section: Int) -> Int {
        if let s = _source { return s[section].count }
        return 0
    }
    
    /// 设置代理内容
    ///
    /// - Parameters:
    ///   - source: 数据
    ///   - identify: reused id
    ///   - cellName: cell class name
    func config(_ source : [[Any]],
                _ identify : String,
                _ cellName : String? = nil) {
        _source = [[Any]].init(source)
        
        var clsName = identify
        if let cls = cellName {
            clsName = cls
        }
        _cellClass = NSClassFromString(clsName)
    }
}
