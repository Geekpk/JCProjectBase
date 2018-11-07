//
//  JCCheckDataTypeUtils.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation

class JCCheckDataTypeUtils: NSObject {
    /**
     *  判断对象是否为空,防止类型转换崩溃,,转换为NSInteger类型
     *
     *  @param object 对象
     *
     *  @return NSInteger
     */
    static func integerValueWithObject(_ obj : Any?) -> Int32 {
        if obj is NSNull || obj == nil {
            return 0
        }
        if obj is String {
            if (obj as? String) == "" {
                return 0
            }
            return NSString.init(string: (obj as! String)).intValue
        }
        if obj is NSString {
            if (obj as? NSString) == "" {
                return 0
            }
            return ((obj as? NSString)?.intValue)!
        }
        if obj is NSNumber {
            return ((obj as? NSNumber)?.int32Value)!
        }
        return 0
    }
    /**
     *  判断对象是否为空,防止类型转换崩溃,,转换为BOOL类型
     *
     *  @param object 对象
     *
     *  @return BOOL
     */
    static func boolValueWithObject(_ obj : Any?) -> Bool {
        if obj is NSNull || obj == nil {
            return false
        }
        if obj is String {
            if (obj as? String) == "" {
                return false
            }
            return NSString.init(string: (obj as! String)).boolValue
        }
        if obj is NSString {
            if (obj as? NSString) == "" {
                return false
            }
            return ((obj as? NSString)?.boolValue)!
        }
        if obj is NSNumber {
            return ((obj as? NSNumber)?.boolValue)!
        }
        return false
    }
    
    /// 邮箱符合性验证。
    ///
    /// - Parameter email: email
    static func isValidateEmail(_ email : String) -> Bool {
        let preStr = "\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"
        let pre = NSPredicate.init(format: "SELF MATCHES %@", preStr)
        return pre.evaluate(with: email)
    }
    
    /// 判断全是数字
    ///
    /// - Parameter string: 字符串
    /// - Returns: bool
    static func isNumber(_ string : String) -> Bool {
        let preStr = "^[0-9]*$"
        let pre = NSPredicate.init(format: "SELF MATCHES %@", preStr)
        return pre.evaluate(with: string)
    }
    
    /// 判断全是字母
    ///
    /// - Parameter string: 字符串
    /// - Returns: bool
    static func isEnglishWords(_ string : String) -> Bool {
        let preStr = "^[A-Za-z]+$"
        let pre = NSPredicate.init(format: "SELF MATCHES %@", preStr)
        return pre.evaluate(with: string)
    }
    
    /// 字母数字下划线，6－12位
    ///
    /// - Parameter string: 字符串
    /// - Returns: bool
    static func isValidatePassword(_ string : String) -> Bool {
        let preStr = "^[\\w\\d_]{6,12}$"
        let pre = NSPredicate.init(format: "SELF MATCHES %@", preStr)
        return pre.evaluate(with: string)
    }
    
    /// 判断全是中文
    ///
    /// - Parameter string: 字符串
    /// - Returns: bool
    static func isChineseWords(_ string : String) -> Bool {
        let preStr = "^[\\u4e00-\\u9fa5] + $"
        let pre = NSPredicate.init(format: "SELF MATCHES %@", preStr)
        return pre.evaluate(with: string)
    }
    
    /// 验证是否为网络链接。
    ///
    /// - Parameter string: 字符串
    /// - Returns: bool
    static func isInternetUrl(_ string : String) -> Bool {
        let preStr = "^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$"
        let pre = NSPredicate.init(format: "SELF MATCHES %@", preStr)
        return pre.evaluate(with: string)
    }
    
    /// 判断是否是电话号码
    ///
    /// - Parameter string: 字符串
    /// - Returns: bool
    static func isPhoneNumber(_ string : String) -> Bool {
        if string.count != 11 || !string.hasPrefix("1") {
            return false
        }
        return JCCheckDataTypeUtils.isNumber(string)
    }
    
    /// 判断是否是身份证号
    ///
    /// - Parameter string: 字符串
    /// - Returns: bool
    static func isIdentifyCardNumber(_ string : String) -> Bool {
        let preStr = "^\\d{15}|\\d{}18$"
        let pre = NSPredicate.init(format: "SELF MATCHES %@", preStr)
        return pre.evaluate(with: string)
    }
    
    
}
