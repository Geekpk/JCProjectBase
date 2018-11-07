//
//  UIStoryboard_Extension.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func initControllerWithID(_ id : String, _ name : String?) -> UIViewController {
        if let n = name {
            let sb = UIStoryboard.init(name: n, bundle: Bundle.main)
            return sb.instantiateViewController(withIdentifier: id)
        }else{
            let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            return sb.instantiateViewController(withIdentifier: id)
        }
    }
}
