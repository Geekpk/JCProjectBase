//
//  UITableView_Extension.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/25.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
extension UITableView {
    
    func setHandle(_ obj : JCTableDelegateHandle) {
        delegate = obj
        dataSource = obj
    }
}
