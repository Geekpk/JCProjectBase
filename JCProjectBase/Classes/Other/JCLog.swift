//
//  JCLog.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
public enum JCLogLevel: String {
    case low    = "---"
    case mid    = "+++"
    case high   = "###"
    case custom = ">>>"
}
public func JCLog<T>(_ logLevel : JCLogLevel? = .low, message : T, file : String = #file, lineNumber : Int = #line, method : String = #function) {
    
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let date : Date = Date.init()
    let f : DateFormatter = DateFormatter.init()
    f.dateFormat = "HH:mm:ss"
    let dateStr = f.string(from: date)
    print("[\(logLevel?.rawValue ?? "") : \(dateStr) : \(fileName):line:\(lineNumber)]- \(method): \(message)")
    #else
    ///donothing
    #endif
}


