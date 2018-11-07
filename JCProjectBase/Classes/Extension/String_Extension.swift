//
//  String_Extension.swift
//  JCProgramBase
//
//  Created by 江城 on 2018/10/19.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import Foundation
extension String {
    //    NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
    func widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : font], context: nil)
        return ceil(rect.width)
    }
    
    func heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : font], context: nil)
        return ceil(rect.height)
    }
    
    func heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
    
    func cutToArray(_ handle : String) -> [String] {
        var piece = components(separatedBy: CharacterSet.init(charactersIn: handle))
        let ps = Array.init(piece)
        for p in ps {
            //移除空字符串
            if p.count == 0 {
                let index = piece.index(of: p)
                if let i = index {
                    piece.remove(at: i)
                }
            }
        }
        return piece
    }
    
    /// 转字符串--->URL
    ///
    /// - Returns: URL?
    func transformToURLString() -> URL? {
        if let tstr = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let str = NSString.init(string: tstr).utf8String {
            return URL.init(string: String.init(cString: str))
        }
        return nil
    }
    
    /// 类方法，字符串转URL
    ///
    /// - Parameter str: 需要转的字符串
    /// - Returns: URL?
    static func transformToURLString(_ str : String?) -> URL? {
        return str?.transformToURLString()
    }
}
