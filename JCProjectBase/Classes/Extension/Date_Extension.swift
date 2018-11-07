//
//  Date_Extension.swift
//  SLProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
extension Date {
    static func intChangeToString(_ v : Int64) -> String {
        let date = Date.init(timeIntervalSince1970: TimeInterval(v))
        let fomate = DateFormatter.init()
        fomate.dateFormat = "yyyy年MM月dd日"
        return fomate.string(from: date)
        
    }
}
