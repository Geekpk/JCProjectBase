//
//  JCModel.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/17.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//
import Mantle
import Foundation
class JCModel: MTLModel, MTLJSONSerializing {
    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        var keyValues = [AnyHashable : Any].init()
        var count : UInt32 = 0
        //获取属性列表
        let ivarlist = class_copyIvarList(self.classForCoder(), &count)
        for i in 0..<count {
            //获取属性名称
            let propertyNameC = ivar_getName(ivarlist![Int(i)])
            var propertyName = String.init(cString: propertyNameC!)
            
            if propertyName == "jc_description" {
                keyValues[propertyName] = "description"
            }else{
                //保存
                keyValues[propertyName] = propertyName
            }
        }
        defer {
            //指针销毁
            ivarlist?.deinitialize(count: Int(count))
            ivarlist?.deallocate()
        }
        return keyValues;
    }
}
