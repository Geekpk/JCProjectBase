//
//  JCTableDelegateHandle.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/17.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
class JCTableDelegateHandle: JCDelegateHandle, UITableViewDelegate, UITableViewDataSource {
    
    private var didSelectRowCallBack : ((UITableView, IndexPath, Any) -> ())?
    
    /// 设置代理内容
    ///
    /// - Parameters:
    ///   - source: 数据
    ///   - identify: reused id
    ///   - cellName: cell class name
    func config(_ source : [[Any]],
                _ identify : String,
                _ cellName : String? = nil,
                DidSelectRow cellBlock : ((UITableView, IndexPath, Any) -> ())?) {
        super.config(source, identify, cellName)
        
        if let b = cellBlock { didSelectRowCallBack = b }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellClassName, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let b = didSelectRowCallBack, let s = source {
            b(tableView, indexPath, s[indexPath.section][indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
