//
//  CollectionDelegateHandle.swift
//  MBAComing
//
//  Created by 江城 on 2018/10/25.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
class CollectionDelegateHandle: JCDelegateHandle, UICollectionViewDataSource, UICollectionViewDelegate {
    private var didSelectRowCallBack : ((UICollectionView, IndexPath, Any) -> ())?
    /// 设置代理内容
    ///
    /// - Parameters:
    ///   - source: 数据
    ///   - identify: reused id
    ///   - cellName: cell class name
    func config(_ source : [[Any]],
                _ identify : String,
                _ cellName : String? = nil,
                DidSelectRow cellBlock : ((UICollectionView, IndexPath, Any) -> ())?) {
        super.config(source, identify, cellName)
        if let b = cellBlock { didSelectRowCallBack = b }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: cellClassName, for: indexPath)
        return item
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let b = didSelectRowCallBack, let s = source {
            b(collectionView, indexPath, s[indexPath.section][indexPath.item])
        }
    }
}
