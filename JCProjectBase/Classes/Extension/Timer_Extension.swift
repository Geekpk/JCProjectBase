//
//  Timer_Extension.swift
//  MBAComing
//
//  Created by 江城 on 2018/10/23.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
extension Timer {
    static func end(_ t : inout Timer?) {
        if let _ = t {
            t?.invalidate()
            t = nil
        }
    }
}
