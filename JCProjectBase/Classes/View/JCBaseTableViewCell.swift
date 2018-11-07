//
//  JCBaseTableViewCell.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/24.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit

class JCBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var cellClassName : String {
        return NSString.init(cString: object_getClassName(self), encoding: String.Encoding.utf8.rawValue)!.components(separatedBy: ".").last!
    }
    
    func config(_ m : AnyObject?) { }
    
    /// 注册
    ///
    /// - Parameters:
    ///   - table: table
    ///   - isNIB: 是否注册nib
    ///   - identify: id & 以及nib名字
    // WARNING: --- nib名字与关联class名字必须相同
    static func register(_ table: UITableView, _ isNIB : Bool = true, _ identify : String? = nil) {
        JCLog(message: self.cellClassName)
        if isNIB {
            let nib = UINib.init(nibName: cellClassName, bundle: nil)
            table.register(nib, forCellReuseIdentifier: identify ?? self.cellClassName)
            
        }else{
            table.register(object_getClass(self), forCellReuseIdentifier: identify ?? self.cellClassName)
        }
    }
}
